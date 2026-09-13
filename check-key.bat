@echo off
setlocal EnableExtensions
chcp 65001 >nul

:: Must run as Administrator
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo.
    echo [LOI] Vui long mo CMD bang Run as administrator.
    echo.
    pause
    exit /b 1
)

title Kiem Tra Ban Quyen Windows 11 & Office

echo ========================================================
echo        1. KIEM TRA BAN QUYEN WINDOWS 11
echo ========================================================
cscript //nologo "%windir%\system32\slmgr.vbs" /dli
 echo.
cscript //nologo "%windir%\system32\slmgr.vbs" /xpr

echo.
echo ========================================================
echo        2. KIEM TRA BAN QUYEN OFFICE- nhap key ban quyen
echo ========================================================
set "OSPP_PATH="
if exist "%ProgramFiles%\Microsoft Office\root\Office16\OSPP.VBS" set "OSPP_PATH=%ProgramFiles%\Microsoft Office\root\Office16"
if not defined OSPP_PATH if exist "%ProgramFiles%\Microsoft Office\Office16\OSPP.VBS" set "OSPP_PATH=%ProgramFiles%\Microsoft Office\Office16"
if not defined OSPP_PATH if defined ProgramFiles(x86) if exist "%ProgramFiles(x86)%\Microsoft Office\Office16\OSPP.VBS" set "OSPP_PATH=%ProgramFiles(x86)%\Microsoft Office\Office16"

if not defined OSPP_PATH (
    echo Khong tim thay OSPP.VBS cua Office.
    echo.
    pause
    exit /b 0
)

pushd "%OSPP_PATH%"
echo Duong dan Office: %OSPP_PATH%
echo.
cscript //nologo OSPP.VBS /dstatus

echo.
echo ========================================================
echo        3. REMOVE KEY QJ7KX (NEU CAN)
echo ========================================================
set /p "confirm=Co muon remove key QJ7KX? [Y/N]: "
if /I "%confirm%"=="Y" (
    echo Dang remove key QJ7KX...
    cscript //nologo OSPP.VBS /unpkey:QJ7KX
    cscript //nologo OSPP.VBS /rearm
    echo.
    echo Da yeu cau remove key QJ7KX.
    echo Khong thuc hien /rearm.
) else (
    echo Bo qua, khong thay doi key.
)
popd

echo.
echo ========================================================
echo Hoan tat.
echo ========================================================
pause
endlocal
