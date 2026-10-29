@echo off
chcp 65001 > nul
cd /d "%~dp0"

set "input=%~1"

cls
echo ===================================================
echo               SQUARE ICON GENERATOR
echo ===================================================
echo.

if "%input%"=="" (
    set /p "input=>> Drag image file here and press Enter: "
)

set "input=%input:"=%"

if not exist "%input%" (
    echo.
    echo [ERROR] File not found: "%input%"
    echo.
    pause
    exit /b
)

echo.
set "name=icon"
set /p "user_name=>> Enter base name [Press Enter for 'icon']: "
if defined user_name set "name=%user_name%"
set "name=%name:"=%"
if "%name%"=="" set "name=icon"

echo.
echo Processing square icons for "%name%"...

C:\ffmpeg.exe -hide_banner -loglevel error -i "%input%" -filter_complex "[0:v]format=rgba,crop='min(iw,ih)':'min(iw,ih)'[sq];[sq]split=5[s16][s48][s64][s128][s256];[s16]scale=16:16:flags=lanczos[out16];[s48]scale=48:48:flags=lanczos[out48];[s64]scale=64:64:flags=lanczos[out64];[s128]scale=128:128:flags=lanczos[out128];[s256]scale=256:256:flags=lanczos[out256]" -map "[out16]" -y "%name%16.png" -map "[out48]" -y "%name%48.png" -map "[out64]" -y "%name%64.png" -map "[out128]" -y "%name%128.png" -map "[out256]" -y "%name%256.png"

if errorlevel 1 (
    echo.
    echo [ERROR] Processing failed!
    echo.
    pause
    exit /b
)

echo.
echo ===================================================
echo                 SUCCESS! CREATED FILES:
echo ===================================================
echo  [+] %name%16.png   (16x16)
echo  [+] %name%48.png   (48x48)
echo  [+] %name%64.png   (64x64)
echo  [+] %name%128.png  (128x128)
echo  [+] %name%256.png  (256x256)
echo ===================================================
echo.
pause