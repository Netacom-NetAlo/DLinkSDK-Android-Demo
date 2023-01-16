// Top-level build file where you can add configuration options common to all sub-projects/modules.
buildscript {
    val hiltVersion = "2.42"
    repositories {
        google()
        mavenCentral()
        mavenLocal()
        maven(url = "https://jitpack.io")
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.4.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.6.21")
        classpath("com.google.dagger:hilt-android-gradle-plugin:$hiltVersion")
    }
}

subprojects {
    afterEvaluate {
        configurations.all {
            resolutionStrategy.eachDependency {
                when (requested.module.toString()) {
                    "androidx.core:core-ktx" -> useVersion("1.8.0")
                    "androidx.annotation:annotation-experimental" -> useVersion("1.2.0")
                }
            }
        }
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
