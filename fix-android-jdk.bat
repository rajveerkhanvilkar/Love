@echo off
echo ========================================
echo FIXING ANDROID BUILD - JDK ISSUE
echo ========================================
echo.

cd android

echo Step 1: Cleaning build cache...
rmdir /s /q .gradle 2>nul
rmdir /s /q build 2>nul
rmdir /s /q app\build 2>nul
echo ✅ Cache cleaned!
echo.

echo Step 2: Updating gradle.properties for JDK compatibility...
echo. >> gradle.properties
echo # Fix JDK compatibility >> gradle.properties
echo org.gradle.jvmargs=-Xmx2048m -XX:MaxMetaspaceSize=512m >> gradle.properties
echo android.useAndroidX=true >> gradle.properties
echo android.enableJetifier=true >> gradle.properties
echo org.gradle.java.home=C:\\Program Files\\Android\\Android Studio\\jbr >> gradle.properties
echo ✅ Gradle properties updated!
echo.

cd ..

echo ========================================
echo ✅ FIX APPLIED!
echo ========================================
echo.
echo NOW IN ANDROID STUDIO:
echo 1. File ^> Invalidate Caches / Restart
echo 2. Choose "Invalidate and Restart"
echo 3. Wait for restart and sync
echo 4. Build ^> Build APK
echo.
echo OR BUILD VIA COMMAND LINE:
echo cd android
echo .\gradlew clean assembleDebug
echo.
pause
