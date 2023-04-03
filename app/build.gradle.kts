plugins {
    id("com.android.application")
    id("kotlin-android")
    id("kotlin-kapt")
    id("dagger.hilt.android.plugin")
}

android {
    compileSdk = 32
    buildToolsVersion = "32.0.0"

    defaultConfig {
        applicationId = "com.netacom.dlinksdkandroid"
        minSdk = 23
        targetSdk = 31
        versionCode = 1
        versionName = "1.0"
        vectorDrawables.useSupportLibrary = true
    }
    buildFeatures {
        viewBinding = true
        dataBinding = true
    }
    packagingOptions {
        jniLibs {
            pickFirsts += setOf("**/lib/**")
        }
        resources {
            excludes += setOf(
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE",
                "META-INF/LICENSE.txt",
                "META-INF/license.txt",
                "META-INF/NOTICE",
                "META-INF/NOTICE.txt",
                "META-INF/notice.txt",
                "META-INF/ASL2.0",
                "META-INF/*.kotlin_module"
            )
            pickFirsts += setOf("**/lib/**")
        }
    }
    signingConfigs {
        create("release") {
            storeFile = file("demo.jks")
            storePassword = "123456"
            keyAlias = "Demo"
            keyPassword = "123456"
        }
    }
    buildTypes {
        getByName("release")  {
            signingConfig = signingConfigs.getByName("release")
            isShrinkResources = true
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    val hiltVersion = "2.42"
    val sdkNetAloVersion = "3.1.47"
    implementation("androidx.appcompat:appcompat:1.5.0") {
        exclude(group = "androidx.core", module = "core")
    }
    implementation("androidx.core:core-ktx:1.8.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
//    debugImplementation("vn.netacom:NetAloFull-Dev:$sdkNetAloVersion") //(for dev)
//    releaseImplementation("vn.netacom:NetAloFull:$sdkNetAloVersion") //(for production)
    implementation("com.stringee.sdk.android:stringee-android-sdk:1.9.8")
    implementation("vn.netacom:NetAloFull:$sdkNetAloVersion") {
        exclude(group = "com.github.webrtc-sdk", module = "android")
    }
    implementation("com.google.dagger:hilt-android:$hiltVersion")
    kapt("com.google.dagger:hilt-android-compiler:$hiltVersion")
    implementation("androidx.hilt:hilt-work:1.0.0")
    kapt("androidx.hilt:hilt-compiler:1.0.0")
}