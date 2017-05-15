//
//  JsTrigger.m
//  IdentifyQrCode
//
//  Created by 汤义 on 17/5/15.
//  Copyright © 2017年 汤义. All rights reserved.
//

#import "JsTrigger.h"

@implementation JsTrigger
-(void)bitUrl:(NSString *)url {
    if (_returnUrlBlock != nil) {
        _returnUrlBlock(url);
    }
}
@end
