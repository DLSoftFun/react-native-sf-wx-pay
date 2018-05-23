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
## Android 端
* 1.0
* 在SDK中找到jar包，导入，或直接添加依赖
* compile 'com.tencent.mm.opensdk:wechat-sdk-android-with-mta:1.0.2' // 微信支付
* 2.0
* 配置清单文件
* 权限
* <uses-permission android:name="android.permission.INTERNET"/>
* <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
* <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
* <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
* <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
*  微信支付
* <activity
* android:name=".wxapi.WXPayEntryActivity"
* android:exported="true"
* android:launchMode="singleTop"/>


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
|Pay|dictionary|dictionary|需要传递的参数|SFWxpay.Pay('','',()=>{'支付成功回调'})|


