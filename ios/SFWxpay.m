//
//  SFWxpay.m
//  SFWxpay
//
//  Created by LZW on 2018/4/12.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SFWxpay.h"
#import "WXApi.h"
#import "zqMd5.h"
@implementation SFWxpay
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();
-(instancetype)init{
  self = [super init];
  if(self){
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
  }
  return self;
}
-(void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification

{
  if ([notification.object isEqualToString:@"success"]) {
       _callback(@[[NSNull null],@"1"]);
  } else {
       _callback(@[[NSNull null],@"0"]);
  }
 
  
}
RCT_EXPORT_METHOD(configure:(NSDictionary*)dic){
      [WXApi registerApp:[dic objectForKey:@"appid"]];
      self.appid = [dic objectForKey:@"appid"];
      self.partnerId = [dic objectForKey:@"partnerId"];
}
RCT_EXPORT_METHOD(pay:(NSDictionary*)dic callback:(RCTResponseSenderBlock)callback){
    _callback = callback;
    NSString *string = [NSString stringWithFormat:@"appid=%@&noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%d&key=%@",
                        self.appid,
                        [dic objectForKey:@"nonceStr"],
                        @"Sign=WXPay",
                        self.partnerId,
                        [dic objectForKey:@"prepayId"],
                        [[dic objectForKey:@"timeStamp"] intValue],
                        @"Q1W2E3R4T5Y6U7I8O9P0111111111111"];
    NSString *sign = [zqMd5 md5_16_low:string];
    
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = self.partnerId;
    req.prepayId            = [dic objectForKey:@"prepayId"];
    req.nonceStr            = [dic objectForKey:@"nonceStr"];
    req.timeStamp           = [[dic objectForKey:@"timeStamp"] intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = sign;
    [WXApi sendReq:req];

}
@end
