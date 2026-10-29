@echo off
setlocal enabledelayedexpansion
title Unlock MCBE Levil - Made by Hirotokuga
color 0A

:: Đường dẫn mặc định đến thư mục versions của LeviLauncher
set "VERSIONS_DIR=%APPDATA%\levilauncher.exe\versions"

:MAIN_MENU
cls
echo ===================================================
echo              UNLOCK MCBE LEVIL
echo             Made by Hirotokuga
echo ===================================================
echo.
echo  [1] Unlock phien ban cu the
echo  [2] Bo Unlock phien ban (Khoi phuc ve mac dinh)
echo  [3] Thoat
echo.
set /p "choice=Chon tuy chon (1-3) va nhan Enter: "

if "%choice%"=="1" goto UNLOCK_VERSION
if "%choice%"=="2" goto RESTORE_VERSION
if "%choice%"=="3" exit /b
goto MAIN_MENU

:GET_VERSIONS
set "count=0"
if not exist "%VERSIONS_DIR%" (
    if exist ".\versions" set "VERSIONS_DIR=.\versions"
)
for /d %%D in ("%VERSIONS_DIR%\*") do (
    if exist "%%D\Minecraft.Windows.exe" (
        set /a count+=1
        set "ver_!count!=%%D"
        set "ver_name_!count!=%%~nxD"
    )
)
exit /b

:UNLOCK_VERSION
cls
echo ===================================================
echo               CHON PHIEN BAN DE UNLOCK
echo ===================================================
echo.
if not exist "winmm.dll" (
    echo [LOI] Khong tim thay file winmm.dll trong cung thu muc!
    echo Vui long dat file winmm.dll cung thu muc voi file .bat nay.
    echo.
    pause
    goto MAIN_MENU
)

call :GET_VERSIONS

if %count%==0 (
    echo Khong tim thay phien ban Minecraft Bedrock nao trong LeviLauncher!
    echo.
    pause
    goto MAIN_MENU
)

for /l %%I in (1,1,%count%) do (
    echo  [%%I] !ver_name_%%I!
)
echo.
echo  [0] Quay lai Menu chinh
echo.
set /p "vchoice=Nhap so phien ban ban muon Unlock va nhan Enter: "

if "%vchoice%"=="0" goto MAIN_MENU
if defined ver_%vchoice% (
    set "target_dir=!ver_%vchoice%!"
    copy /y "winmm.dll" "!target_dir!\winmm.dll" >nul
    echo.
    echo [THANH CONG] Da unlock phien ban !ver_name_%vchoice%!
    echo.
    pause
    goto MAIN_MENU
) else (
    echo Lua chon khong hop le!
    pause
    goto UNLOCK_VERSION
)

:RESTORE_VERSION
cls
echo ===================================================
echo            CHON PHIEN BAN DE BO UNLOCK
echo ===================================================
echo.
call :GET_VERSIONS

if %count%==0 (
    echo Khong tim thay phien ban Minecraft Bedrock nao!
    echo.
    pause
    goto MAIN_MENU
)

for /l %%I in (1,1,%count%) do (
    echo  [%%I] !ver_name_%%I!
)
echo.
echo  [0] Quay lai Menu chinh
echo.
set /p "vchoice=Nhap so phien ban ban muon bo Unlock va nhan Enter: "

if "%vchoice%"=="0" goto MAIN_MENU
if defined ver_%vchoice% (
    set "target_dir=!ver_%vchoice%!"
    if exist "!target_dir!\winmm.dll" (
        del /f /q "!target_dir!\winmm.dll"
        echo.
        echo [THANH CONG] Da xoa winmm.dll. Phien ban !ver_name_%vchoice%! da tro ve mac dinh!
    ) else (
        echo.
        echo Phien ban nay chua duoc unlock (khong tim thay winmm.dll).
    )
    echo.
    pause
    goto MAIN_MENU
) else (
    echo Lua chon khong hop le!
    pause
    goto RESTORE_VERSION
)