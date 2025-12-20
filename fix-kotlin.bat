@echo off
echo Fixing Kotlin dependency conflicts...

cd android

echo.
echo Adding Kotlin dependency resolution to build.gradle...

REM Create a temporary PowerShell script to modify build.gradle
powershell -Command "$content = Get-Content 'app\build.gradle' -Raw; if ($content -notmatch 'configurations.all') { $content = $content -replace '(dependencies \{)', \"configurations.all {`n    resolutionStrategy {`n        force 'org.jetbrains.kotlin:kotlin-stdlib:1.8.10'`n        force 'org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.10'`n        force 'org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.10'`n    }`n}`n`n`$1\"; Set-Content 'app\build.gradle' $content }"

echo.
echo ✅ Fixed Kotlin dependencies!
echo.
echo Now rebuilding...
cd ..

echo.
echo Run this in Android Studio:
echo Build ^> Clean Project
echo Then: Build ^> Build APK
echo.
pause
