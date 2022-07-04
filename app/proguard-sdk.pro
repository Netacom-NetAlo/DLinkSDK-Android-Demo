
-flattenpackagehierarchy 'com.netacom.full'
-flattenpackagehierarchy 'com.netacom.lite'
-ignorewarnings

#--------------- Begin : appsflyer -----------
-keep public class com.android.installreferrer.** { *; }
-dontwarn com.android.installreferrer
-dontwarn com.appsflyer.*
#--------------- End : appsflyer -----------

#--------------- Begin : androidx -----------
-keep class androidx.core.content.ContextCompat { *; }
#--------------- End : androidx -----------

#--------------- Begin : Encrypted -----------
-keep class androidx.core.app.CoreComponentFactory { *; }
-dontwarn androidx.core.app.CoreComponentFactory.**
-keep class * extends com.google.crypto.tink.shaded.protobuf.GeneratedMessageLite { *; }
-keep class * extends com.google.protobuf.GeneratedMessageLite { *; }
-dontwarn org.conscrypt.**
-keepclassmembers class * extends com.google.crypto.tink.shaded.protobuf.GeneratedMessageLite {
  <fields>;
}
#--------------- End : Encrypted -----------

#--------------- Begin : Android Utils Code -----------
-dontwarn com.netacom.base.chat.android_utils.**
-keepclassmembers class * {
    @com.netacom.base.chat.android_utils.BusUtils$Bus <methods>;
}
-keep public class * extends com.netacom.base.chat.android_utils.ApiUtils$BaseApi
-keep,allowobfuscation @interface com.netacom.base.chat.android_utils.ApiUtils$Api
-keep @com.netacom.base.chat.android_utils.ApiUtils$Api class *
#--------------- End : Android Utils Code -----------

#--------------- Begin : WebRTC -----------
-keep class org.webrtc.** { *; }
-keep class org.appspot.apprtc.** { *; }
-keep interface org.webrtc.** { *; }
-keep class de.tavendo.autobahn.** { *; }
-dontwarn org.webrtc.voiceengine.WebRtcAudioTrack
-keep class com.cloudwebrtc.webrtc.** { *; }
-keepclasseswithmembernames class * { native <methods>; }
-dontwarn org.chromium.build.BuildHooksAndroid
#--------------- End : WebRTC -----------

#--------------- Begin : Kotlin Coroutine -----------
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepnames class kotlinx.coroutines.android.AndroidExceptionPreHandler {}
-keepnames class kotlinx.coroutines.android.AndroidDispatcherFactory {}
# Most of volatile fields are updated with AFU and should not be mangled
-keepclassmembernames class kotlinx.** {
    volatile <fields>;
}
# Same story for the standard library's SafeContinuation that also uses AtomicReferenceFieldUpdater
-keepclassmembernames class kotlin.coroutines.SafeContinuation {
    volatile <fields>;
}
# https://github.com/Kotlin/kotlinx.atomicfu/issues/57
-dontwarn kotlinx.atomicfu.**
-dontwarn kotlinx.coroutines.flow.**
# kotlinx-coroutines-core is used as a Java agent, so these are not needed in contexts where ProGuard is used.
-dontwarn java.lang.instrument.ClassFileTransformer
-dontwarn sun.misc.SignalHandler
-dontwarn java.lang.instrument.Instrumentation
-dontwarn sun.misc.Signal
#--------------- End : Kotlin Coroutine -----------

#--------------- Begin : Native -----------
-keepclassmembers class * {
	@android.webkit.JavascriptInterface <methods>;
}
-keepclassmembers public class * extends android.view.View {
    void set*(***);
    *** get*();
}
-keepclassmembers class * extends android.app.Activity {
    public void *(android.view.View);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keepclassmembers class * implements android.os.Parcelable {
    public static final ** CREATOR;
}
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

-keepclassmembers class **.R$* {
    public static <fields>;
}
-dontnote android.support.**
-dontnote androidx.**
-dontwarn android.support.**
-dontwarn androidx.**
-dontwarn android.util.FloatMath
-keep class android.support.annotation.Keep
-keep class androidx.annotation.Keep
-keep @android.support.annotation.Keep class * {*;}
-keep @androidx.annotation.Keep class * {*;}
-keepclasseswithmembers class * {
    @android.support.annotation.Keep <methods>;
}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <methods>;
}
-keepclasseswithmembers class * {
    @android.support.annotation.Keep <fields>;
}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <fields>;
}
-keepclasseswithmembers class * {
    @android.support.annotation.Keep <init>(...);
}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <init>(...);
}

-dontwarn kotlin.reflect.jvm.internal.impl.descriptors.CallableDescriptor
-dontwarn kotlin.reflect.jvm.internal.impl.descriptors.ClassDescriptor
-dontwarn kotlin.reflect.jvm.internal.impl.descriptors.ClassifierDescriptorWithTypeParameters
-dontwarn kotlin.reflect.jvm.internal.impl.descriptors.annotations.AnnotationDescriptor
-dontwarn kotlin.reflect.jvm.internal.impl.descriptors.impl.PropertyDescriptorImpl
-dontwarn kotlin.reflect.jvm.internal.impl.load.java.JavaClassFinder
-dontwarn kotlin.reflect.jvm.internal.impl.resolve.OverridingUtil
-dontwarn kotlin.reflect.jvm.internal.impl.types.DescriptorSubstitutor
-dontwarn kotlin.reflect.jvm.internal.impl.types.DescriptorSubstitutor
-dontwarn kotlin.reflect.jvm.internal.impl.types.TypeConstructor
#--------------- End : Native -----------

#--------------- Begin : React Native -----------
# Keep our interfaces so they can be used by other ProGuard rules.
# See http://sourceforge.net/p/proguard/bugs/466/
-keep,allowobfuscation @interface com.facebook.proguard.annotations.DoNotStrip
-keep,allowobfuscation @interface com.facebook.proguard.annotations.KeepGettersAndSetters
-keep,allowobfuscation @interface com.facebook.common.internal.DoNotStrip

# Do not strip any method/class that is annotated with @DoNotStrip
-keep @com.facebook.proguard.annotations.DoNotStrip class *
-keep @com.facebook.common.internal.DoNotStrip class *
-keepclassmembers class * {
    @com.facebook.proguard.annotations.DoNotStrip *;
    @com.facebook.common.internal.DoNotStrip *;
}

-keepclassmembers @com.facebook.proguard.annotations.KeepGettersAndSetters class * {
  void set*(***);
  *** get*();
}

-keep class * extends com.facebook.react.bridge.JavaScriptModule { *; }
-keep class * extends com.facebook.react.bridge.NativeModule { *; }
-keepclassmembers,includedescriptorclasses class * { native <methods>; }
-keepclassmembers class *  { @com.facebook.react.uimanager.UIProp <fields>; }
-keepclassmembers class *  { @com.facebook.react.uimanager.annotations.ReactProp <methods>; }
-keepclassmembers class *  { @com.facebook.react.uimanager.annotations.ReactPropGroup <methods>; }
-dontwarn com.facebook.react.**
-keep,includedescriptorclasses class com.facebook.react.bridge.** { *; }
#--------------- End : React Native -----------

#--------------- Start : Kotlinx serialization -----------
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt # core serialization annotations

# kotlinx-serialization-json specific. Add this if you have java.lang.NoClassDefFoundError kotlinx.serialization.json.JsonObjectSerializer
-keepclassmembers class kotlinx.serialization.json.** {
    *** Companion;
}
-keepclasseswithmembers class kotlinx.serialization.json.** {
    kotlinx.serialization.KSerializer serializer(...);
}

# Change here com.yourcompany.yourpackage
-keep,includedescriptorclasses class com.yourcompany.yourpackage.**$$serializer { *; } # <-- change package name to your app's
-keepclassmembers class com.yourcompany.yourpackage.** { # <-- change package name to your app's
    *** Companion;
}
-keepclasseswithmembers class com.yourcompany.yourpackage.** { # <-- change package name to your app's
    kotlinx.serialization.KSerializer serializer(...);
}
#--------------- End : Kotlinx serialization -----------
-keep class com.google.** {*;}
-keep interface com.google.** {*;}
-keep enum com.google.** {*;}
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

#noinspection ShrinkerUnresolvedReference
-keepclassmembers class com.google.android.gms.dynamite.DynamiteModule {
    #noinspection ShrinkerUnresolvedReference
    ** MODULE_ID;
    ** MODULE_VERSION;
    ** sClassLoader;
}
-keepclassmembers class com.google.android.gms.internal.in {
    ** mOrigin;
    ** mCreationTimestamp;
    ** mName;
    ** mValue;
    ** mTriggerEventName;
    ** mTimedOutEventName;
    ** mTimedOutEventParams;
    ** mTriggerTimeout;
    ** mTriggeredEventName;
    ** mTriggeredEventParams;
    ** mTimeToLive;
    ** mExpiredEventName;
    ** mExpiredEventParams;
}
-keepclassmembers class com.google.devtools.build.android.desugar.runtime.ThrowableExtension {
    ** SDK_INT;
}
-keep class com.google.android.gms.dynamic.IObjectWrapper
-keep class com.google.android.gms.tasks.Task
-keep class com.google.android.gms.tasks.TaskCompletionSource
-keep class com.google.android.gms.tasks.OnSuccessListener
-keep class com.google.android.gms.tasks.OnFailureListener
-keep class com.google.android.gms.tasks.OnCompleteListener
-keep class com.google.android.gms.tasks.Continuation
-keep class com.google.android.gms.measurement.AppMeasurement$EventInterceptor
-keep class com.google.android.gms.measurement.AppMeasurement$OnEventListener
-keep class com.google.android.gms.measurement.AppMeasurement$zza
-keep class com.google.android.gms.internal.zzcgl
-keep class com.google.android.gms.internal.zzbhh
-keep class com.google.android.gms.internal.aad
-keep class com.google.android.gms.internal.aae
-keep class com.google.android.gms.internal.iq
-keep class com.google.android.gms.internal.ly
-keep class com.google.android.gms.internal.kx
-keep class com.google.android.gms.internal.xf
-keep class com.google.android.gms.internal.qu
-keep class com.google.android.gms.internal.qr
-keep class com.google.android.gms.internal.xm
-keep class com.google.android.gms.internal.aaj
-keep class com.google.android.gms.internal.aat
-keep class com.google.android.gms.internal.aah
-keep class com.google.android.gms.internal.rx
-keep class com.google.android.gms.internal.qg
-keep class com.google.android.gms.internal.sh
-keep class com.google.android.gms.internal.qu
-keep class com.google.android.gms.internal.vq
-keep class com.google.android.gms.internal.qi
-keep class com.google.android.gms.internal.oh
-keep class com.google.android.gms.internal.oo
-keep class com.google.android.gms.internal.oc
-keep class com.google.android.gms.internal.oi
-keep class com.google.android.gms.internal.ol
-keep class com.google.android.gms.internal.wn
-keep class com.google.android.gms.internal.oj
-keep class com.google.android.gms.internal.om
-keep class com.google.android.gms.internal.pf
-keep class com.google.android.gms.internal.za
-keep class com.google.android.gms.internal.pz
-keep class com.google.android.gms.internal.zn
-keep class com.google.android.gms.internal.zi
-keep class com.google.android.gms.internal.aen
-keep class com.google.android.gms.internal.aas
-keep class com.google.android.gms.internal.aav
-keep class com.google.android.gms.internal.aag
-keep class com.google.android.gms.internal.abh
-keep class com.google.android.gms.internal.abk
-keep class com.google.android.gms.internal.abq
-keep class com.google.android.gms.internal.abl
-keep class com.google.android.gms.internal.acf
-keep class com.google.android.gms.common.api.Result
-keep class com.google.android.gms.common.zza

-dontnote com.google.android.gms.internal.ql
-dontnote com.google.android.gms.internal.zzcem
-dontnote com.google.android.gms.internal.zzchl

# Firebase notes
-dontnote com.google.firebase.messaging.zza

# Protobuf notes
-dontnote com.google.protobuf.zzc
-dontnote com.google.protobuf.zzd
-dontnote com.google.protobuf.zze

## Android Advertiser ID
-keep class com.google.android.gms.common.GooglePlayServicesUtil {*;}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {*;}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {*;}

### Crashlytics
# In order to provide the most meaningful crash reports
-keepattributes SourceFile,LineNumberTable
# If you're using custom Eception
-keep public class * extends java.lang.Exception
-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.android.**
-dontwarn com.crashlytics.**
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

#Message
-dontwarn com.google.android.gms.measurement.AppMeasurement*

# We keep all fields for every generated proto file as the runtime uses
# reflection over them that ProGuard cannot detect. Without this keep
# rule, fields may be removed that would cause runtime failures.
-keepclassmembers class * extends com.google.android.gms.internal.measurement.zzyv {
  <fields>;
}
#--------------- Begin : okhttp3 -----------
# https://github.com/square/okhttp/blob/master/okhttp/src/main/resources/META-INF/proguard/okhttp3.pro
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-dontwarn okhttp3.internal.platform.*
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*
# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform
-dontwarn org.conscrypt.ConscryptHostnameVerifier
### Other
-dontwarn com.google.errorprone.annotations.*
-dontwarn com.squareup.okhttp.**
#--------------- End : okhttp3 -----------

#--------------- begin : Okio ----------
-keep class sun.misc.Unsafe { *; }
-dontwarn java.nio.file.*
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn okio.**
-keep public class org.codehaus.* { *; }
-dontwarn com.squareup.**
-keep public class java.nio.* { *; }
##---------------End: Okio  ----------

#--------------- begin : Retrofit ----------
# Platform calls Class.forName on types which do not exist on Android to determine platform.
-dontnote retrofit2.Platform
# Platform used when running on RoboVM on iOS. Will not be used at runtime.
-dontnote retrofit2.Platform$IOS$MainThreadExecutor
# Platform used when running on Java 8 VMs. Will not be used at runtime.
-dontwarn retrofit2.Platform$Java8
# Retain declared checked exceptions for use by a Proxy instance.
-keepattributes Exceptions
-keepattributes Signature, InnerClasses, EnclosingMethod
# Retain service method parameters when optimizing.
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
# Retrofit does reflection on method and parameter annotations.
-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations
# Ignore annotation used for build tooling.
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
# Ignore JSR 305 annotations for embedding nullability information.
-dontwarn javax.annotation.**
# Guarded by a NoClassDefFoundError try/catch and only used when on the classpath.
-dontwarn kotlin.Unit
# Top-level functions that can only be used by Kotlin.
-dontwarn retrofit2.KotlinExtensions
-dontwarn retrofit2.KotlinExtensions$*
# With R8 full mode, it sees no subtypes of Retrofit interfaces since they are created with a Proxy
# and replaces all potential values with null. Explicitly keeping the interfaces prevents this.
-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>
##---------------End: Retrofit  ----------

#--------------- begin : Moshi ----------
-keep class kotlin.reflect.jvm.internal.impl.builtins.BuiltInsLoaderImpl
-keep class kotlin.Metadata { *; }
-keep class kotlin.Metadata {
    public <methods>;
}
-keepclassmembers class kotlin.Metadata {
    public <methods>;
}
-dontwarn javax.annotation.**
-keepclasseswithmembers class * {
    @com.squareup.moshi.* <methods>;
}
-keep @com.squareup.moshi.JsonQualifier interface *
# Enum field names are used by the integrated EnumJsonAdapter.
# values() is synthesized by the Kotlin compiler and is used by EnumJsonAdapter indirectly
# Annotate enums with  @JsonClass(generateAdapter = false) to use them with Moshi.
-keepclassmembers @com.squareup.moshi.JsonClass class * extends java.lang.Enum {
    <fields>;
    **[] values();
}
# Keep helper method to avoid R8 optimisation that would keep all Kotlin Metadata when unwanted
-keepclassmembers class com.squareup.moshi.internal.Util {
    private static java.lang.String getKotlinMetadataClassName();
}
-dontwarn okio.**
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.ParametersAreNonnullByDefault
#######
-keepclasseswithmembers class * {
    @com.squareup.moshi.* <methods>;
}
-keep @com.squareup.moshi.JsonQualifier interface *
-dontwarn org.jetbrains.annotations.**
-keepclassmembers class * {
    @com.squareup.moshi.FromJson <methods>;
    @com.squareup.moshi.ToJson <methods>;
}
-dontwarn org.jetbrains.annotations.**
-keep class kotlin.Metadata { *; }
-keepclassmembers class com.asia.** { <init>(...); <fields>;}
-keep @android.support.annotation.Keep class * {*;}
-keepnames @com.squareup.moshi.JsonClass class *

# Retain generated JsonAdapters if annotated type is retained
-if @com.squareup.moshi.JsonClass class *
-keep class <1>JsonAdapter {
    <init>(...);
    <fields>;
}

##---------------End: Moshi  ----------

### Retrolambda
# as per official recommendation: https://github.com/evant/gradle-retrolambda#proguard
-dontwarn java.lang.invoke.*

#--------------- begin : gson ----------
# Application classes that will be serialized/deserialized over Gson
# Prevent proguard from stripping interface information from TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in  @JsonAdapter)
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keep class sun.misc.Unsafe { *; }
-dontwarn sun.misc.**
-keep class com.google.gson.stream.** { *; }
##---------------End: gson  ----------

#--------------- begin : Realm ----------
-dontnote io.realm.internal.SyncObjectServerFacade
-keep class io.realm.annotations.RealmModule
-keep @io.realm.annotations.RealmModule class *
-keep class io.realm.internal.Keep
-keep @io.realm.internal.Keep class * { *; }
-keep class io.realm.internal.KeepMember
-keep @io.realm.internal.KeepMember class * { @io.realm.internal.KeepMember *; }
-dontwarn javax.**
-dontwarn io.realm.**
-keep class io.realm.RealmCollection
-keep class io.realm.OrderedRealmCollection
-keepclasseswithmembernames class io.realm.** {
    native <methods>;
}
-dontnote rx.Observable
-dontnote android.security.KeyStore
-dontwarn okio.Okio
-dontwarn okio.DeflaterSink
-dontnote com.android.org.conscrypt.SSLParametersImpl
-dontnote org.apache.harmony.xnet.provider.jsse.SSLParametersImpl
-dontnote sun.security.ssl.SSLContextImpl
-keep class io.realm.** { *; }
##---------------End: Realm  ----------

#--------------- begin : Glide ----------
-dontwarn com.bumptech.glide.**
-keep class com.bumptech.glide.**{*;}
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
-keep class com.bumptech.glide.load.data.ParcelFileDescriptorRewinder$InternalRewinder {
  *** rewind();
}
-keep class com.uphyca.** { *; }
-dontwarn jp.co.cyberagent.android.gpuimage.**
##---------------End: Glide  ----------

#--------------- begin : Libs ----------
-keep class org.joda.time.** { *; }
-keep class okio.** { *; }
-keep class com.google.gson.**{ *; }
-keep class com.github.moduth.blockcanary.**{ *; }
-dontwarn com.github.moduth.blockcanary.**
-keep class okio.**{ *; }
-dontwarn okio.**
-keep class rx.**{ *; }
-dontwarn rx.**
-dontwarn com.google.android.exoplayer2.**
##---------------End: Libs  ----------

#--------------- begin : Facebook ----------
# Do not strip any method/class that is annotated with @DoNotStrip
-keep @com.facebook.common.internal.DoNotStrip class *
-keepclassmembers class * {
#noinspection ShrinkerUnresolvedReference
    @com.facebook.common.internal.DoNotStrip *;
}
# Do not strip any method/class that is annotated with @DoNotOptimize
-keep @com.facebook.soloader.DoNotOptimize class *
-keepclassmembers class * {
#noinspection ShrinkerUnresolvedReference
    @com.facebook.soloader.DoNotOptimize *;
}
##---------------End: Facebook  ----------

#--------------- begin : Stetho ----------
-keep class com.facebook.stetho.** { *; }
-keep class com.uphyca.** { *; }
-dontwarn com.facebook.stetho.**
##---------------End: Stetho  ----------

# dagger
-dontwarn dagger.internal.codegen.**
-keepclassmembers,allowobfuscation class * {
    @javax.inject.* *;
    @dagger.* *;
    <init>();
}

-keep class dagger.* { *; }
-keep class javax.inject.* { *; }
-keep class * extends dagger.internal.Binding
-keep class * extends dagger.internal.ModuleAdapter
-keep class * extends dagger.internal.StaticInjection

# dagger2
# https://github.com/google/dagger/issues/645
-dontwarn com.google.errorprone.annotations.*

#--------------- begin : Hilt ----------
#Hilt
-keep,allowobfuscation,allowshrinking @dagger.hilt.android.EarlyEntryPoint class *
# Keep class names of Hilt injected ViewModels since their name are used as a multibinding map key.
-keepnames @dagger.hilt.android.lifecycle.HiltViewModel class * extends androidx.lifecycle.ViewModel
-dontwarn com.google.errorprone.annotations.**
-keep public class dagger.hilt.** { *; }
-dontwarn dagger.hilt
-dontwarn dagger.hilt.*
-keepnames class dagger.**
-keep class androidx.hilt.work.** { *; }
##---------------End: Hilt  ----------

#--------------- begin : Leakcanary ----------
# A ContentProvider that gets created by Android on startup
-keep class leakcanary.internal.AppWatcherInstaller { <init>(); }
# KeyedWeakReference is looked up in the hprof file
-keep class leakcanary.KeyedWeakReference { *; }
-keep class org.eclipse.mat.** { *; }
-keep class com.squareup.leakcanary.** { *; }
##---------------End: Leakcanary  ----------

#--------------- begin : Encrypted ----------
-keepclassmembers class * extends com.google.crypto.tink.shaded.protobuf.GeneratedMessageLite {
  <fields>;
}
##---------------End: Encrypted  ----------

#--------------- begin : Sentry ----------
-keep class io.sentry.android.core.SentryAndroidOptions
-keep class io.sentry.android.ndk.SentryNdk
##---------------End: Sentry  ----------

#--------------- begin : Whispersystems ----------
-keepnames class org.whispersystems.curve25519.NativeCurve25519Provider {}
-keepnames class org.whispersystems.curve25519.JavaCurve25519Provider {}
-keepnames class org.whispersystems.curve25519.J2meCurve25519Provider {}
-keepnames class org.whispersystems.curve25519.OpportunisticCurve25519Provider {}
-keep class org.whispersystems.curve25519.NativeCurve25519Provider {}
-keep class org.whispersystems.curve25519.JavaCurve25519Provider {}
-keep class org.whispersystems.curve25519.J2meCurve25519Provider {}
-keep class org.whispersystems.curve25519.OpportunisticCurve25519Provider {}
##---------------End: Whispersystems  ----------

#--------------- begin : Jisti Meet SDK ----------
-keep class org.jitsi.meet.** { *; }
-keep class org.jitsi.meet.sdk.** { *; }

# We added the following when we switched minifyEnabled on. Probably because we
# ran the app and hit problems...

-keep class com.facebook.react.bridge.CatalystInstanceImpl { *; }
-keep class com.facebook.react.bridge.ExecutorToken { *; }
-keep class com.facebook.react.bridge.JavaScriptExecutor { *; }
-keep class com.facebook.react.bridge.ModuleRegistryHolder { *; }
-keep class com.facebook.react.bridge.ReadableType { *; }
-keep class com.facebook.react.bridge.queue.NativeRunnable { *; }
-keep class com.facebook.react.devsupport.** { *; }

-dontwarn com.facebook.react.devsupport.**
-dontwarn com.google.appengine.**
-dontwarn com.squareup.okhttp.**
-dontwarn javax.servlet.**

# ^^^ We added the above when we switched minifyEnabled on.

# Rule to avoid build errors related to SVGs.
-keep public class com.horcrux.svg.** {*;}
##---------------End: Jisti Meet SDK  ----------
##SocketIO
-keep class io.socket.** { *; }