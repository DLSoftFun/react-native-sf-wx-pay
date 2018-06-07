//
//
//  Created by LZW on 2018/4/12.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SFWXPay.h"
#import "WXApi.h"
#import "zqMd5.h"
@implementation SFWXPay
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE(SFWXPay);
-(instancetype)init{
  self = [super init];
  if(self){
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"PAY_WECHAT" object:nil];
  }
  return self;
}

-(void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)getOrderPayResult:(NSNotification *)notification
{
    NSString * errcode = [NSString stringWithFormat:@"%ld",[notification.userInfo[@"respCode"]integerValue]];
    NSString* errMessage = notification.userInfo[@"respStr"];
    [self.bridge.eventDispatcher sendAppEventWithName:@"WeChatResp"
                                                 body:@{@"errCode":errcode,@"errMessage": errMessage}];
}
#pragma mark - 收到支付成功的消息后作相应的处理
RCT_EXPORT_METHOD(registerApp:(NSDictionary*)dic){
      [WXApi registerApp:[dic objectForKey:@"appid"]];
      self.partnerId=[dic objectForKey:@"partnerId"];
}
RCT_EXPORT_METHOD(pay:(NSDictionary*)dic){

    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = self.partnerId;
    req.prepayId            = [dic objectForKey:@"prepayId"];
    req.nonceStr            = [dic objectForKey:@"nonceStr"];
    req.timeStamp           = [[dic objectForKey:@"timeStamp"] intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = [dic objectForKey:@"sign"];
    [WXApi sendReq:req];

}
//#pragma mark - 收到支付成功的消息后作相应的处理
//- (void)onResp:(BaseResp *)resp
//
//{
//    //    支付结果回调
//    if([resp isKindOfClass:[PayResp class]]){
//        switch (resp.errCode) {
//            case WXSuccess:{
//                _callback(@[[NSNull null],@"1"]);
//                NSLog(@"支付成功");
//                break;
//            }
//            case WXErrCodeUserCancel:
//            {
//                _callback(@[[NSNull null],@"2"]);
//                NSLog(@"取消支付");
//                break;
//            }
//            default:{
//                NSString* failCode = [NSString stringWithFormat:@"%d",resp.errCode];
//                NSString* failMsg = [NSString stringWithFormat:@"errorStr: %@",resp.errStr];
//                NSArray * event = @[failCode,failMsg];
//                _callback(@[[NSNull null],event]);
//                NSLog(@"支付失败");
//                break;
//            }
//        }
//
//    }
//
//}
@end
