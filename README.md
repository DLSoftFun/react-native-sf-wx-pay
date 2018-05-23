# react-native-sf-wx-pay

# react-native 列表

# 安装
* npm i react-native-sf-wx-pay
* react-native link  react-native-sf-wx-pay
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


