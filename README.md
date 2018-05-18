# react-native-sf-wx-pay

# react-native 列表

# 安装
* npm i react-native-sf-wx-pay

# 说明
IOS 端
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

# Methods
|  Methods  |  Params  |  Param Types  |   description  |  Example  |
|:-----|:-----|:-----|:-----|:-----|
|registerApp|string|string|微信注册appid|SFWxpay.registerApp('')|
|Pay|dictionary|dictionary|需要传递的参数|SFWxpay.Pay(‘’,()=>{'支付成功回调'})|


