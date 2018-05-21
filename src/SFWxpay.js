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
 **/
var SFWxpay = NativeModules.SFWxpay
export default class SFWxpay extends React.Component{
    // 注册
    static registerApp=(appid)=>{
        SFWxpay.registerApp({
            'appid':appid,

        })
    }
    // 支付
    static Pay=(partnerId,prepayId,nonceStr,timeStamp,callback)=>{
        SFWxpay.pay({
            'partnerId':partnerId,
            'prepayId':prepayId,
            'nonceStr':nonceStr,
            'timeStamp':timeStamp,
        },(error,events)=>{
            if(error){
                console.error(error);
            }else{
                if(events==0){
                }else {
                    if(callback){
                        callback()
                    }
                }
            }
        })
    }

}