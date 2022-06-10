dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        mavenLocal()
        gradlePluginPortal()
        maven(url = "https://jitpack.io")
        maven(url = "https://plugins.gradle.org/m2/")
        maven(url = "https://github.com/Netacom-NetAlo/NetaloSDKs-Android/raw/main/NetAloSDK")
        maven(url = "https://github.com/ToanMobile/JitsiNetAlo/raw/main/releaseVNDirectOld")
//        maven {
//            setUrl("https://github.com/Netacom-NetAlo/NetaloSDKs-Android/raw/main/NetAloSDK")
//        }
//        maven(url = "https://github.com/jitsi/jitsi-maven-repository/raw/master/releases")
    }
}
rootProject.name = "DLinkSDKAndroid"
include(":app")
 