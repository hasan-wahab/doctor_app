import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile =
    file("C:/Users/DELL/StudioProjects/Neon/AllAppScreenShot/doctorkeystore/key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val storeFilePath = keystoreProperties.getProperty("storeFile")
val storePasswordValue = keystoreProperties.getProperty("storePassword")
val keyAliasValue = keystoreProperties.getProperty("keyAlias")
val keyPasswordValue = keystoreProperties.getProperty("keyPassword")
val hasReleaseKeystore =
    storeFilePath != null &&
        storePasswordValue != null &&
        keyAliasValue != null &&
        keyPasswordValue != null

android {
    namespace = "com.neonweb.dralitherapy_patientapp"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    if (hasReleaseKeystore) {
        signingConfigs {
            create("release") {
                storeFile = file(storeFilePath!!)
                storePassword = storePasswordValue
                keyAlias = keyAliasValue
                keyPassword = keyPasswordValue
            }
        }
    }

    defaultConfig {
        applicationId = "com.neonweb.dralitherapy_patientapp"
        // Flutter default is 24 (FlutterExtension). Literal helps Android Studio inspections
        // ("current min is 1") when the Flutter Gradle model is not loaded yet.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 17
        versionName = "1.0.16"
        ndk {
            abiFilters += listOf("arm64-v8a", "armeabi-v7a")
        }
    }

    buildTypes {
        release {
            if (hasReleaseKeystore) {
                signingConfig = signingConfigs.getByName("release")
            }
        }
    }
}

flutter {
    source = "../.."
}
