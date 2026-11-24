@echo off
chcp 65001 > nul
cd /d "%~dp0"

set "input=%~1"

cls
echo ===================================================
echo                םיאוגולו םינוקיא רצוי
echo ===================================================
echo.

if not "%input%"=="" goto GOT_FILE

set /p "input=:Enter ץחלו הנומתה ץבוק תא ןאכל רורג << "

:GOT_FILE
if defined input set "input=%input:"=%"

if not exist "%input%" (
    echo.
    echo [!] !ןיוצש ביתנב אצמנ אל ץבקה :האיגש
    echo.
    pause
    exit /b
)

echo.
set "name=icon"
set "user_name="
set /p "user_name=:[icon רובע Enter ץחל] םיצבקל םש ןזה << "
if defined user_name set "name=%user_name%"
set "name=%name:"=%"
if "%name%"=="" set "name=icon"

echo.
echo :ןוקייאה תרוצ תא רחב
echo   [1] לוגיע
echo   [2] עבורמ
echo   [3] לגועמ
echo   [4] לוטיב
echo.
set "shape=1"
set "user_shape="
set /p "user_shape=:[1 :לדחמ תרירב] תורשפא רחב << "
if defined user_shape set "shape=%user_shape%"

if "%shape%"=="4" goto CANCEL_EXIT
if "%shape%"=="2" goto SHAPE_SQUARE
if "%shape%"=="3" goto SHAPE_ROUNDED
goto SHAPE_CIRCLE

:CANCEL_EXIT
echo.
echo ...האיצי - הלטוב הלועפה
exit /b

:SHAPE_CIRCLE
C:\ffmpeg.exe -hide_banner -loglevel error -i "%input%" -filter_complex "[0:v]format=rgba,crop='min(iw,ih)':'min(iw,ih)',scale=512:512,geq=r='r(X,Y)':g='g(X,Y)':b='b(X,Y)':a='alpha(X,Y)*clip(256-hypot(X-255.5,Y-255.5)+0.5,0,1)'[circle];[circle]split=6[s16][s32][s48][s64][s128][s256];[s16]scale=16:16:flags=lanczos[out16];[s32]scale=32:32:flags=lanczos[out32];[s48]scale=48:48:flags=lanczos[out48];[s64]scale=64:64:flags=lanczos[out64];[s128]scale=128:128:flags=lanczos[out128];[s256]scale=256:256:flags=lanczos[out256]" -map "[out16]" -y "%name%16.png" -map "[out32]" -y "%name%32.png" -map "[out48]" -y "%name%48.png" -map "[out64]" -y "%name%64.png" -map "[out128]" -y "%name%128.png" -map "[out256]" -y "%name%256.png"
goto CHECK_RESULT

:SHAPE_SQUARE
C:\ffmpeg.exe -hide_banner -loglevel error -i "%input%" -filter_complex "[0:v]format=rgba,crop='min(iw,ih)':'min(iw,ih)'[sq];[sq]split=6[s16][s32][s48][s64][s128][s256];[s16]scale=16:16:flags=lanczos[out16];[s32]scale=32:32:flags=lanczos[out32];[s48]scale=48:48:flags=lanczos[out48];[s64]scale=64:64:flags=lanczos[out64];[s128]scale=128:128:flags=lanczos[out128];[s256]scale=256:256:flags=lanczos[out256]" -map "[out16]" -y "%name%16.png" -map "[out32]" -y "%name%32.png" -map "[out48]" -y "%name%48.png" -map "[out64]" -y "%name%64.png" -map "[out128]" -y "%name%128.png" -map "[out256]" -y "%name%256.png"
goto CHECK_RESULT

:SHAPE_ROUNDED
C:\ffmpeg.exe -hide_banner -loglevel error -i "%input%" -filter_complex "[0:v]format=rgba,crop='min(iw,ih)':'min(iw,ih)',scale=512:512,geq=r='r(X,Y)':g='g(X,Y)':b='b(X,Y)':a='alpha(X,Y)*clip(110-hypot(max(abs(X-255.5)-146,0),max(abs(Y-255.5)-146,0))+0.5,0,1)'[rounded];[rounded]split=6[s16][s32][s48][s64][s128][s256];[s16]scale=16:16:flags=lanczos[out16];[s32]scale=32:32:flags=lanczos[out32];[s48]scale=48:48:flags=lanczos[out48];[s64]scale=64:64:flags=lanczos[out64];[s128]scale=128:128:flags=lanczos[out128];[s256]scale=256:256:flags=lanczos[out256]" -map "[out16]" -y "%name%16.png" -map "[out32]" -y "%name%32.png" -map "[out48]" -y "%name%48.png" -map "[out64]" -y "%name%64.png" -map "[out128]" -y "%name%128.png" -map "[out256]" -y "%name%256.png"
goto CHECK_RESULT

:CHECK_RESULT
if errorlevel 1 (
    echo.
    echo [X] !םיצבקה תריציב הלשכנ הדוקפה :האיגש
    echo.
    pause
    exit /b
)

echo.
echo ===================================================
echo                !הצלחהב ורצונ םיצבקה
echo ===================================================
echo  [+] %name%16.png   (16x16)
echo  [+] %name%32.png   (32x32)
echo  [+] %name%48.png   (48x48)
echo  [+] %name%64.png   (64x64)
echo  [+] %name%128.png  (128x128)
echo  [+] %name%256.png  (256x256)
echo ===================================================
echo.
pause