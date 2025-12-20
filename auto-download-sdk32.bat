@echo off
echo ========================================
echo AUTO-DOWNLOADING ANDROID SDK 32
echo ========================================
echo.

set ANDROID_SDK=%LOCALAPPDATA%\Android\Sdk
set SDKMANAGER=%ANDROID_SDK%\cmdline-tools\latest\bin\sdkmanager.bat

echo Checking for SDK Manager...
if not exist "%SDKMANAGER%" (
    echo ERROR: SDK Manager not found!
    echo.
    echo Please download SDK 32 manually:
    echo 1. Open Android Studio
    echo 2. Tools -^> SDK Manager
    echo 3. Check "Android 12L (S) - API Level 32"
    echo 4. Click "Apply"
    echo.
    pause
    exit /b 1
)

echo.
echo [1/3] Downloading Android SDK Platform 32...
echo This will take 2-5 minutes...
echo.

call "%SDKMANAGER%" "platforms;android-32" --sdk_root="%ANDROID_SDK%"

echo.
echo [2/3] Accepting licenses...
echo.

echo y | call "%SDKMANAGER%" --licenses --sdk_root="%ANDROID_SDK%"

echo.
echo [3/3] Verifying installation...
echo.

if exist "%ANDROID_SDK%\platforms\android-32" (
    echo.
    echo ========================================
    echo SUCCESS! SDK 32 INSTALLED!
    echo ========================================
    echo.
    echo Next steps:
    echo 1. Close this window
    echo 2. Go to Android Studio
    echo 3. File -^> Invalidate Caches -^> Invalidate and Restart
    echo 4. After restart, Build -^> Build APK
    echo.
    echo YOU'RE ALMOST THERE!
    echo.
) else (
    echo.
    echo ========================================
    echo DOWNLOAD FAILED
    echo ========================================
    echo.
    echo Please download manually in Android Studio:
    echo Tools -^> SDK Manager -^> Check "Android 12L (S) - API 32"
    echo.
)

pause
