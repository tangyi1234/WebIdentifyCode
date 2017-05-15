//
//  WebView.h
//  WebIdentifyCode
//
//  Created by 汤义 on 17/5/15.
//  Copyright © 2017年 汤义. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebView : UIView
+ (instancetype)initView;
- (void)loadingWebView:(NSString *)webUrl;
@end
