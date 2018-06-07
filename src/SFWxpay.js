import React, {Component} from 'react';
import {
    NativeModules,
    NativeAppEventEmitter
  } from 'react-native'; 
/**
 * @param appid 微信申请支付id
 * @param partnerId 合作id
 * @param prepayId  订单id
 * @param nonceStr  随机串
 * @param timeStamp 时间戳
 * @param sign 标签
 **/
var SFWXpay = NativeModules.SFWXPay
export default class SFWxpay extends React.Component{
    // 注册
    static registerApp=(appid,partnerId)=>{
        SFWXpay.registerApp({
            'appid':appid,
            'partnerId':partnerId
        })
    }
    // 支付
    static Pay=(prepayId,nonceStr,timeStamp,sign)=>{
        SFWXpay.pay({
            'prepayId':prepayId,
            'nonceStr':nonceStr,
            'timeStamp':timeStamp,
            'sign':sign
        })
    
    }
}