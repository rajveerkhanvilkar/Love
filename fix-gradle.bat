@echo off
echo Fixing Gradle version for Java 21 compatibility...
echo.

cd android\gradle\wrapper

(
echo distributionBase=GRADLE_USER_HOME
echo distributionPath=wrapper/dists
echo distributionUrl=https\://services.gradle.org/distributions/gradle-8.4-all.zip
echo networkTimeout=10000
echo validateDistributionUrl=true
echo zipStoreBase=GRADLE_USER_HOME
echo zipStorePath=wrapper/dists
) > gradle-wrapper.properties

echo.
echo Gradle updated to version 8.4
echo.
echo Now close Android Studio and run it again!
pause
