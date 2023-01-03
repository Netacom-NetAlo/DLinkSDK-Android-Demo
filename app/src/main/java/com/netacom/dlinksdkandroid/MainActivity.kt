package com.netacom.dlinksdkandroid

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatEditText
import androidx.core.os.bundleOf
import com.asia.sdkbase.binding.clickDebounce
import com.asia.sdkbase.logger.Logger
import com.asia.sdkcore.config.EndPoint
import com.asia.sdkcore.define.ErrorCodeDefine
import com.asia.sdkcore.define.GalleryType
import com.asia.sdkcore.entity.ui.local.LocalFileModel
import com.asia.sdkcore.entity.ui.theme.NeTheme
import com.asia.sdkcore.entity.ui.user.NeUser
import com.asia.sdkcore.network.model.response.SettingResponse
import com.asia.sdkcore.util.CallbackResult
import com.asia.sdkui.ui.sdk.NetAloSDK
import com.google.android.material.snackbar.Snackbar
import com.google.firebase.messaging.RemoteMessage
import kotlinx.coroutines.*
import org.json.JSONObject


@ObsoleteCoroutinesApi
@ExperimentalCoroutinesApi
@FlowPreview
class MainActivity : AppCompatActivity() {
    //private val user8 = NeUser(id = 4785074605935470, token = "06239ce309736f7b4eef9095709b63435e3467B6", username = "Test123")
    private val user8 = NeUser(id = 4785074617709103, token = "07958b840be4082c4b5cadea73353f4293658dMr", username = "ToanMobile")
    private val user9 = NeUser(id = 4785074617579316, token = "", username = "DLink")
    private var isUser8 = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)
        NetAloSDK.registerClickNotification(context = this, intent = intent)
        resultListener()
        initSDK()
        findViewById<AppCompatButton>(R.id.btnSdkThemeGreen).clickDebounce {
            NetAloSDK.initTheme(
                NeTheme(
                    mainColor = "#00B14F",
                    subColorLight = "#D6F3E2",
                    subColorDark = "#683A00",
                    toolbarDrawable = "#00B14F"
                )
            )
        }

        findViewById<AppCompatButton>(R.id.btnSdkThemeOrange).clickDebounce {
            NetAloSDK.initTheme(
                NeTheme(
                    mainColor = "#FF9500",
                    subColorLight = "#F9D9C9",
                    subColorDark = "#ef5222",
                    toolbarDrawable = "#FF9500"
                )
            )
        }

        findViewById<AppCompatButton>(R.id.btnSetUser1).clickDebounce {
            isUser8 = true
            NetAloSDK.setNetAloUser(this, user8)
        }

        findViewById<AppCompatButton>(R.id.btnSetUser2).clickDebounce {
            isUser8 = false
            NetAloSDK.setNetAloUser(this, user9)
        }

        findViewById<AppCompatButton>(R.id.btnSdkOpen).clickDebounce {
            NetAloSDK.openNetAloSDK(this)
            MainScope().launch {
                delay(5000)
                // NetAloSDK.getListContactLocal()
            }
        }

        findViewById<AppCompatButton>(R.id.btnSdkOpenChat).clickDebounce {
            NetAloSDK.openNetAloSDK(
                context = this,
                neUserChat = if (isUser8) user9 else user8
            )
        }

        findViewById<AppCompatButton>(R.id.btnBlockUser).clickDebounce {
            NetAloSDK.blockUser(userId = user9.id, isBlock = true, callbackResult = object : CallbackResult<Boolean> {
                override fun callBackSuccess(result: Boolean) {
                    Logger.e("btnBlockUser:callBackSuccess=")
                }

                override fun callBackError(error: String?) {
                    Logger.e("btnBlockUser:callBackError=")
                }

            })
        }

        findViewById<AppCompatButton>(R.id.btnCustomUser).clickDebounce {
            val userId = findViewById<AppCompatEditText>(R.id.editId).text.toString().toLongOrNull()
            val token = findViewById<AppCompatEditText>(R.id.editToken).text.toString()
            if (userId == null || token.isEmpty()) {
                Snackbar.make(findViewById(R.id.view), "Mời nhập ID và token để set User custom!", Snackbar.LENGTH_LONG).show()
                return@clickDebounce
            }
            NetAloSDK.setNetAloUser(
                this,
                neUser = NeUser(
                    id = userId,
                    token = token,
                    username = findViewById<AppCompatEditText>(R.id.editName).text.toString(),
                    avatar = findViewById<AppCompatEditText>(R.id.editAvatar).text.toString(),
                )
            )
        }

        findViewById<AppCompatButton>(R.id.btnSdkLogOut).clickDebounce {
            //NetAloSDK.netAloEvent?.send(LocalFileModel(filePath = ""))
            val remoteMessage: RemoteMessage= RemoteMessage(bundleOf())
            //NetAloSDK.initFirebase(applicationContext, remoteMessage)
        }

        findViewById<AppCompatButton>(R.id.btnSdkListContact).clickDebounce {
//            NetAloSDK.getListContactFromServer { listContact ->
//                Logger.e("listContact=" + listContact.map { it })
//            }
        }

        findViewById<AppCompatButton>(R.id.btnStartActivitySdk).clickDebounce {
            NetAloSDK.openGallery(context = this, maxSelections = 1, autoDismissOnMaxSelections = false, galleryType = GalleryType.GALLERY_ALL)
        }

        findViewById<AppCompatButton>(R.id.btnSendNotification).clickDebounce {
            val json = "{\"Payload\":\"{\\\"messageId\\\":\\\"570871223969989172\\\",\\\"groupId\\\":\\\"4791743771110404\\\",\\\"message\\\":\\\"json\\\",\\\"senderUin\\\":\\\"4785074605935470\\\",\\\"createdAt\\\":\\\"1670939212343689\\\",\\\"recipientUins\\\":[\\\"4785074605935470\\\",\\\"4785074604085429\\\"],\\\"senderName\\\":\\\"test123\\\",\\\"groupType\\\":\\\"GROUP_TYPE_PUBLIC\\\",\\\"nonce\\\":\\\"1670939211823960\\\",\\\"version\\\":1}\",\"Type\":\"message\"}"
            val remoteMessage = RemoteMessage.Builder("Data").addData("Data", json).build()
            NetAloSDK.initFirebase(this, remoteMessage)
        }
    }

    private fun initSDK() {
        NetAloSDK.initTheme(
            NeTheme(
                mainColor = "#00B14F",
                subColorLight = "#D6F3E2",
                subColorDark = "#683A00",
                toolbarDrawable = "#00B14F"
            )
        )
        NetAloSDK.initSetting(
            settingResponse = SettingResponse(
                apiEndpoint = EndPoint.URL_API,
                cdnEndpoint = EndPoint.URL_CDN,
                chatEndpoint = EndPoint.URL_SOCKET
            )
        )
    }

    private fun resultListener() {
        CoroutineScope(Dispatchers.Default).launch {
            NetAloSDK.netAloEvent?.receive<ArrayList<LocalFileModel>>()?.collect { listPhoto ->
                Logger.e("SELECT_PHOTO_VIDEO==$listPhoto")
            }
        }

        CoroutineScope(Dispatchers.Default).launch {
            NetAloSDK.netAloEvent?.receive<LocalFileModel>()?.collect { document ->
                Logger.e("SELECT_FILE==$document")
            }

        }

        CoroutineScope(Dispatchers.Default).launch {
            NetAloSDK.netAloEvent?.receive<Map<String, String>>()?.collect { notification ->
                Logger.e("Notification:data==$notification")
            }
        }

        CoroutineScope(Dispatchers.Default).launch {
            NetAloSDK.netAloEvent?.receive<Int>()?.collect { errorEvent ->
                Logger.e("Event:==$errorEvent")
                when (errorEvent) {
                    ErrorCodeDefine.ERRORCODE_FAILED_VALUE -> {
                        Logger.e("Event:Socket error")
                    }
                    ErrorCodeDefine.ERRORCODE_EXPIRED_VALUE -> {
                        Logger.e("Event:Session expired")
                    }
                    ErrorCodeDefine.ERRORCODE_LOGIN_CONFLICT_VALUE -> {
                        Logger.e("Event:Login conflict")
                    }
                }
            }
        }
    }
}