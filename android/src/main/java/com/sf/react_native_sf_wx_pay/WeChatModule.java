package com.sf.react_native_sf_wx_pay;

import android.content.Intent;
import android.widget.Toast;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelpay.PayReq;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Random;

/**
 * Created by Administrator on 2018-04-18.
 */

public class WeChatModule extends ReactContextBaseJavaModule implements IWXAPIEventHandler {
    private String appId;
    private String partnerId;
    private IWXAPI api = null;
    private static ArrayList<WeChatModule> modules = new ArrayList<>();

    public WeChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public void initialize() {
        super.initialize();
        modules.add(this);
    }

    @Override
    public void onCatalystInstanceDestroy() {
        super.onCatalystInstanceDestroy();
        if (api != null) {
            api = null;
        }
        modules.remove(this);
    }
    public static void handleIntent(Intent intent) {
        for (WeChatModule mod : modules) {
            mod.api.handleIntent(intent, mod);
        }
    }

    @Override
    public String getName() {
        return "SFWXPay";
    }

    @Override
    public void onReq(BaseReq baseReq) {

    }

    @Override
    public void onResp(BaseResp baseResp) {

    }
    @ReactMethod
    public void registerApp(ReadableMap data) {
        this.appId = data.getString("appid");
        this.partnerId = data.getString("partnerId");
        api = WXAPIFactory.createWXAPI(this.getReactApplicationContext().getBaseContext(), this.appId, true);
        api.registerApp(this.appId);
    }
    @ReactMethod
    private void Pay(ReadableMap data,Callback callback){
        PayReq request = new PayReq();
        request.appId = appId;
        request.partnerId = partnerId;

        if(data.hasKey("prepayId")){
            request.prepayId = data.getString("prepayId");
        }
        request.packageValue = "Sign=WXPay";
        if(data.hasKey("nonceStr")){
            request.nonceStr = data.getString("nonceStr");
        }
        if(data.hasKey("timeStamp")){
            request.timeStamp = data.getString("timeStamp");
        }
//        String key = "";
//        if(data.hasKey("key")){
//            key = data.getString("key");
//        }
        if(data.hasKey("sign")){
            request.sign = data.getString("sign");
        }
//        String stringA = "appid="+request.appId+"&noncestr="+request.nonceStr+"&package=Sign=WXPay"+"&partnerid="+request.partnerId+"&prepayid="+request.prepayId+"&timestamp="+request.timeStamp+"&key="+key;
//        request.sign = MD5(stringA).toUpperCase();
//                                request.sign = jresult.getString("sign");
        callback.invoke(api.sendReq(request) ? null : "WeChat API invoke returns false.");
    }

    public final static String MD5(String s) {
        char hexDigits[]={'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
        try {
            byte[] btInput = s.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            byte[] md = mdInst.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}