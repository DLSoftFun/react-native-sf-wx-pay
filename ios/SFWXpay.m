//
//
//  Created by LZW on 2018/4/12.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SFWXpay.h"
#import "WXApi.h"
#import "zqMd5.h"
@implementation SFWXpay
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE(SFWXpay);
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
RCT_EXPORT_METHOD(registerApp:(NSDictionary*)dic){
      [WXApi registerApp:[dic objectForKey:@"appid"]];
}
RCT_EXPORT_METHOD(pay:(NSDictionary*)dic callback:(RCTResponseSenderBlock)callback){
    _callback = callback;
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dic objectForKey:@"partnerId"];
    req.prepayId            = [dic objectForKey:@"prepayId"];
    req.nonceStr            = [dic objectForKey:@"nonceStr"];
    req.timeStamp           = [[dic objectForKey:@"timeStamp"] intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = [dic objectForKey:@"sign"];
    [WXApi sendReq:req];

}
#pragma mark - 收到支付成功的消息后作相应的处理
- (void)onResp:(BaseResp *)resp

{
    //    支付结果回调
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:{
                _callback(@[[NSNull null],@"1"]);
                NSLog(@"支付成功");
                break;
            }
            case WXErrCodeUserCancel:
            {
                _callback(@[[NSNull null],@"2"]);
                NSLog(@"取消支付");
                break;
            }
            default:{
                NSString* failCode = [NSString stringWithFormat:@"%d",resp.errCode];
                NSString* failMsg = [NSString stringWithFormat:@"errorStr: %@",resp.errStr];
                NSArray * event = @[failCode,failMsg];
                _callback(@[[NSNull null],event]);
                NSLog(@"支付失败");
                break;
            }
        }
        
    }
    
}
@end
