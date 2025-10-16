@echo off

setlocal enabledelayedexpansion

:: paths (to .exe files or .lnk)
set "paths[0]=______\Docker Desktop.exe"
set "paths[1]=______\LINQPad8.exe"
set "paths[2]=______\dbeaver.exe"
set "paths[3]=______\Obsidian.exe"
set "paths[4]=______\Telegram.lnk"
set "paths[5]=______\devenv.exe"

:: names (to .exe files)
set "names[0]=Docker Desktop.exe"
set "names[1]=LINQPad8.exe"
set "names[2]=dbeaver.exe"
set "names[3]=Obsidian.exe"
set "names[4]=Telegram.exe"
set "names[5]=devenv.exe"

set count=5

:: for before running docker desktop
wsl --update

:: running
for /L %%i in (0,1,!count!) do (
    call :check_and_run "!names[%%i]!" "!paths[%%i]!"
)

echo all programs are running.

goto :end

:check_and_run
set "program_name=%~1"
set "program_path=%~2"

tasklist /FI "IMAGENAME eq %program_name%" | find /I "%program_name%" >nul
if %errorlevel%==0 (
    echo %program_name% is already running.
) else (
    if exist "%program_path%" (
        echo starting %program_name%...
        cmd /c start "" /b "%program_path%" >nul 2>&1
        timeout /t 5 >nul
    ) else (
        echo %program_name% executable not found at %program_path%
    )
)
exit /b

:end
echo end.

timeout /t 5
exit

endlocal