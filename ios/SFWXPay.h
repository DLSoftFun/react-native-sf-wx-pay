//
//  SFWxpay
//
//  Created by LZW on 2018/4/12.
//  Copyright © 2018年 Facebook. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTBridgeModule.h>
@interface SFWXPay : NSObject<RCTBridgeModule>
@property (nonatomic,strong) RCTResponseSenderBlock callback;
@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *partnerId;
@end
