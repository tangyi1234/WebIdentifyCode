//
//  WebView.m
//  WebIdentifyCode
//
//  Created by 汤义 on 17/5/15.
//  Copyright © 2017年 汤义. All rights reserved.
//

#import "WebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIImageView+WebCache.h"
#import <AudioToolbox/AudioToolbox.h>
#import "JsTrigger.h"
@interface WebView()<UIWebViewDelegate>
{
    JSContext *context;
    JsTrigger *interac;
}
@property (nonatomic, weak) UIWebView *webViews;
@property (nonatomic, weak) UIImageView *imageViews;
@property (nonatomic, strong) CIDetector *detector;
@end
@implementation WebView
#pragma make 初始化数据
+ (instancetype)initView {
    return [[WebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWebView];
    }
    return self;
}

- (void)initWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.delegate = self;
    [self addSubview:_webViews = webView];
    
    UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(0, 500, 100, 100)];
    images.hidden = YES;
    [self addSubview:_imageViews = images];
    
    interac = [JsTrigger new];
    __weak typeof(self) make = self;
    interac.returnUrlBlock = ^(NSString *urlStr){
        dispatch_sync(dispatch_get_main_queue(), ^{
            [make toObtainImage:urlStr];
        });
        NSLog(@"请求地址:%@",urlStr);
    };

}

- (void)loadingWebView:(NSString *)webUrl {
   [_webViews loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
}

#pragma make webView代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self injectionJs];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma make 方法集合
- (void)injectionJs {
    [_webViews stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.imageUrl.bitUrl(this.src);}\
     }\
     }"];
    [_webViews stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];

    context = [_webViews valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"imageUrl"] = interac;
}

- (void)toObtainImage:(NSString *)str {
    NSURL *url = [NSURL URLWithString:str];
    //用block 可以在图片加载完成之后做些事情
    [self.imageViews sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.imageViews.image = image;
        NSLog(@"这里有图片没有:%@",image);
        //识别图片是否有二维码
        CIContext *contexts = [CIContext contextWithOptions:nil];
        _detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:contexts options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
        NSArray *features = [self.detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        NSLog(@"有多少个数组:%@",features);
        if (features.count >0) {
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            NSLog(@"这里可以在图片加载完成之后做些事情:%@",scannedResult);
        }

    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
