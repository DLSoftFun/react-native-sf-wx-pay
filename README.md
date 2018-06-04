# react-native-sf-wx-pay

# react-native 列表

# 安装
* npm i react-native-sf-wx-pay
* react-native link  react-native-sf-wx-pay
# 说明
## IOS 端
* 1.0
* 导入库集成SDK
* 2.0
* 需要添加的系统库
* SystemConfiguration.framework
* libz.tbd
* libsqlite3.0.tbd
* CoreTelephony.framework
* QuartzCore.framework
* 3.0
* 设置URL Scheme
* 4.0 在AppDelegate 添加
```
- (BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
sourceApplication:(NSString *)sourceApplication
annotation:(id)annotation {
// 处理微信的支付结果
[WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];

return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
[WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
return YES;
}

//微信回调,有支付结果的时候会回调这个方法

- (void)onResp:(BaseResp *)resp

{
//    支付结果回调
if([resp isKindOfClass:[PayResp class]]){
NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",resp.errCode],@"respCode",resp.errStr,@"respStr",nil];
NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:nil userInfo:dic];
[[NSNotificationCenter defaultCenter] postNotification:notification];
}

}
```
* 5.0 在react 添加监听支付监听
```
import { NativeAppEventEmitter } from 'react-native';
NativeAppEventEmitter.addListener(
'WeChatResp',
(content) => {
//数据内容
}
}
);
this.listener && this.listener.remove();


回调中errCode值列表：

名称      描述    解决方案
0       成功    展示成功页面
-1      错误    可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
-2    用户取消    无需处理。发生场景：用户不支付了，点击取消，返回APP。
```

## Android 端
* 1.0
* 在SDK中找到jar包，导入，或直接添加依赖
* compile 'com.tencent.mm.opensdk:wechat-sdk-android-with-mta:1.0.2' // 微信支付
* 2.0
* 配置清单文件
```
<!--权限-->
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<!-- 微信支付 -->
<activity
android:name=".wxapi.WXPayEntryActivity"
android:exported="true"
android:launchMode="singleTop"/>
```

# Props
|  parameter  |  type  |  required  |   description  |  default  |
|:-----|:-----|:-----|:-----|:-----|
|appid|string|yes|微信支付id|null|
|partnerId|string|yes|合作id|null|
|prepayId|string|yes|订单id|null|
|nonceStr|string|yes|随机串|null|
|timeStamp|string|yes|时间戳|null|
|sign|string|yes|订单标签|null|

# Methods
|  Methods  |  Params  |  Param Types  |   description  |  Example  |
|:-----|:-----|:-----|:-----|:-----|
|registerApp|string|string|微信注册appid|SFWxpay.registerApp('')|
|Pay|dictionary|dictionary|需要传递的参数|SFWxpay.Pay(‘填写多个字符')|


