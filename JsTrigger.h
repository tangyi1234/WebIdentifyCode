//
//  JsTrigger.h
//  IdentifyQrCode
//
//  Created by 汤义 on 17/5/15.
//  Copyright © 2017年 汤义. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol Interactionprotocol <JSExport>
- (void)bitUrl:(NSString *)url;
@end
typedef void (^returnUrl)(NSString *);
@interface JsTrigger : NSObject<Interactionprotocol>
@property (nonatomic, copy) returnUrl returnUrlBlock;
@end
