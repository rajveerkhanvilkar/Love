@echo off
echo.
echo ====================================
echo   Rajveer ^& Swarali Love Diary
echo   Starting Server...
echo ====================================
echo.

REM Check if node_modules exists
if not exist "node_modules\" (
    echo Installing dependencies...
    call npm install
    echo.
)

REM Check if MongoDB is needed
echo.
echo IMPORTANT: Make sure MongoDB is running!
echo.
echo Option 1: Using MongoDB Atlas (Cloud)
echo   - Update MONGODB_URI in .env file
echo.
echo Option 2: Using Local MongoDB
echo   - Start MongoDB service first
echo.
pause

echo.
echo Starting server...
echo.
node server.js
