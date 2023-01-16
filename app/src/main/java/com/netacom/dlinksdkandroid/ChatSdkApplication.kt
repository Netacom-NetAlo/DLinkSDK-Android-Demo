/*
 * *Created by NetaloTeamAndroid on 2020
 * Company: Netacom.
 *  *
 */

@file:OptIn(ObsoleteCoroutinesApi::class, ExperimentalCoroutinesApi::class, FlowPreview::class)

package com.netacom.dlinksdkandroid

import android.app.Application
import android.content.Context
import androidx.work.Configuration
import com.asia.sdkcore.entity.ui.theme.NeTheme
import com.asia.sdkcore.sdk.AccountKey
import com.asia.sdkcore.sdk.AppID
import com.asia.sdkcore.sdk.AppKey
import com.asia.sdkcore.sdk.SdkConfig
import com.asia.sdkui.ui.sdk.NetAloSDK
import com.asia.sdkui.ui.sdk.NetAloSdkCore
import dagger.hilt.android.HiltAndroidApp
import io.realm.Realm
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.ObsoleteCoroutinesApi
import javax.inject.Inject

/**Created by vantoan on 23,July,2020
Company: Netacom.
Email: huynhvantoan.itc@gmail.com
 */

@HiltAndroidApp
class ChatSdkApplication : Application(), Configuration.Provider {

    @Inject
    lateinit var netAloSdkCore: NetAloSdkCore

    override fun getWorkManagerConfiguration() =
        Configuration.Builder()
            .setWorkerFactory(netAloSdkCore.workerFactory)
            .build()

    private val sdkTheme = NeTheme(
        mainColor = "#FF9500",
        subColorLight = "#F9D9C9",
        subColorDark = "#ef5222",
        toolbarDrawable = "#FF9500"
    )

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        Realm.init(this)
    }

    override fun onCreate() {
        super.onCreate()
        NetAloSDK.initNetAloSDK(
            context = this,
            netAloSdkCore = netAloSdkCore,
            sdkConfig = SdkConfig(
                appId = AppID.VNDIRECT,
                appKey = AppKey.VNDIRECT_PRO,
                accountKey = AccountKey.VNDIRECT_PRO,
                isSyncContact = false,
                hidePhone = true,
                hideCreateGroup = true,
                hideAddInfoInChat = true,
                hideInfoInChat = true,
                hideCallInChat = false,
                hideSearch = true,
                classMainActivity = MainActivity::class.java.name
            ),
            neTheme = sdkTheme
        )
    }
}
