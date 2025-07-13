plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.hlfdev.flutter_template"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.hlfdev.flutter_template"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "environment"
    
    productFlavors {
        create("development") {
            dimension = "environment"
            applicationId = "com.hlfdev.flutter_template.dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Flutter Template Dev")
        }
        
        create("staging") {
            dimension = "environment"
            applicationId = "com.hlfdev.flutter_template.staging"
            versionNameSuffix = "-staging"
            resValue("string", "app_name", "Flutter Template Staging")
        }
        
        create("production") {
            dimension = "environment"
            applicationId = "com.hlfdev.flutter_template"
            resValue("string", "app_name", "Flutter Template")
        }
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
            isDebuggable = true
        }
        
        release {
            isMinifyEnabled = true
            isDebuggable = false
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
