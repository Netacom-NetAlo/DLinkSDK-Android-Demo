package com.netacom.vndirect

import com.asia.sdkbase.logger.Logger
import com.asia.sdkui.ui.sdk.NetAloSDK
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {
    override fun onNewToken(token: String) {
        super.onNewToken(token)
        Logger.e("onNewToken::$token")
    }

    override fun onMessageReceived(message: RemoteMessage) {
        super.onMessageReceived(message)
        Logger.e("MyFirebaseMessagingService::${message.data}")
        /*val jsonPayload = JSONObject(message.data.toString()).getJSONObject("Data").getString("Payload")
        val jsonObject = JSONObject(jsonPayload)
        Logger.e("jsonObject::$jsonObject")
        if (jsonObject.has("call")) {
            NetAloSDK.initFirebase(applicationContext, message)
        }*/
        NetAloSDK.initFirebase(applicationContext, message)
    }
}