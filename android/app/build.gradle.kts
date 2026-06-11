    import java.util.Properties
    import java.io.FileInputStream

    plugins {
        id("com.android.application")
        id("org.jetbrains.kotlin.android")
        id("dev.flutter.flutter-gradle-plugin")
    }

    val keystoreProperties = Properties()
    val keystorePropertiesFile =
        file("C:/Users/DELL/StudioProjects/Neon/doctorkeystore/key.properties")

    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    }
    android {
        namespace = "com.neonweb.dralitherapy_patientapp"
        compileSdk = 36
        ndkVersion = "27.0.12077973"

        compileOptions {
            sourceCompatibility = JavaVersion.VERSION_11
            targetCompatibility = JavaVersion.VERSION_11
        }

        kotlinOptions {
            jvmTarget = JavaVersion.VERSION_11.toString()
        }

        signingConfigs {
            create("release") {
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }

        defaultConfig {
            applicationId = "com.neonweb.dralitherapy_patientapp"
            // Flutter default is 24 (FlutterExtension). Literal helps Android Studio inspections
            // ("current min is 1") when the Flutter Gradle model is not loaded yet.
            minSdk = flutter.minSdkVersion
            targetSdk = 36
            versionCode = 2
            versionName = "1.0.1"
//            ndk {
//                abiFilters += listOf("arm64-v8a", "armeabi-v7a", "x86", "x86_64")
//            }
            ndk {
                abiFilters += listOf("arm64-v8a", "armeabi-v7a")
            }
        }

        buildTypes {
            release {
                signingConfig = signingConfigs.getByName("release")
            }
        }
    }

    flutter {
        source = "../.."
    }
