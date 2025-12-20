@echo off
echo ========================================
echo   COUPLES DIARY - QUICK DEPLOY
echo ========================================
echo.

echo Step 1: Checking if Git is installed...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is not installed!
    echo.
    echo Please download Git from: https://git-scm.com/download/win
    echo After installing, run this script again.
    pause
    exit
)

echo Git found!
echo.

echo Step 2: Initializing Git repository...
git init
git add .
git commit -m "Initial commit - Rajveer & Swarali Love Diary"

echo.
echo Step 3: Creating GitHub repository...
echo.
echo MANUAL STEP REQUIRED:
echo 1. Go to: https://github.com/new
echo 2. Repository name: couples-diary
echo 3. Make it PRIVATE
echo 4. Click "Create repository"
echo 5. Copy the repository URL (it looks like: https://github.com/YOUR-USERNAME/couples-diary.git)
echo.
set /p REPO_URL="Paste your GitHub repository URL here: "

echo.
echo Step 4: Pushing to GitHub...
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main

echo.
echo ========================================
echo   SUCCESS! Code uploaded to GitHub!
echo ========================================
echo.
echo Next steps:
echo 1. Go to: https://vercel.com/new
echo 2. Click "Import" next to your couples-diary repository
echo 3. Click "Deploy"
echo 4. Wait 2 minutes
echo 5. You'll get your URL!
echo.
pause
