//
//  ViewController.m
//  WebIdentifyCode
//
//  Created by 汤义 on 17/5/15.
//  Copyright © 2017年 汤义. All rights reserved.
//

#import "ViewController.h"
#import "WebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIImageView+WebCache.h"
#import <AudioToolbox/AudioToolbox.h>
#import "JsTrigger.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    WebView *view = [WebView initView];
    [view loadingWebView:@"https://mp.weixin.qq.com/s?__biz=MjM5MjAxNDM4MA==&mid=2666157300&idx=4&sn=c1ce751339279e9842e4b493cf34566e&chksm=bdb23db78ac5b4a1e94e5b15a22bce54140fa2ea5a6b2a4e68ac7e804c573d1a75d7525f9b31#rd"];
    [self.view addSubview:view];
//    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
