@echo off

setlocal enabledelayedexpansion

:: paths (to .exe files or .lnk)
:: input yours
set "docker_path=C:\Program Files\Docker\Docker\Docker Desktop.exe"
set "linkpad_path=________\LINQPad8.exe"
set "beaver_path=________\dbeaver.exe"
set "obsidian_path=________\Obsidian.exe"
set "telegram_path=________\Telegram.lnk"
set "visualstudio_path=________\devenv.exe"

:: names (to .exe files)
set "docker_name=Docker Desktop.exe"
set "linkpad_name=LINQPad8.exe"
set "beaver_name=dbeaver.exe"
set "obsidian_name=Obsidian.exe"
set "telegram_name=Telegram.exe"
set "visualstudio_name=devenv.exe"

:: for before running docker desktop
wsl --update

:: running
call :check_and_run "%docker_name%" "%docker_path%"
call :check_and_run "%linkpad_name%" "%linkpad_path%"
call :check_and_run "%beaver_name%" "%beaver_path%"
call :check_and_run "%obsidian_name%" "%obsidian_path%"
call :check_and_run "%telegram_name%" "%telegram_path%"
call :check_and_run "%visualstudio_name%" "%visualstudio_path%"

echo all programs are running.

:: try to show the window if it is minimized
call :show-window "%docker_name%"
call :show-window "%linkpad_name%"
call :show-window "%beaver_name%"
call :show-window "%obsidian_name%"
call :show-window "%telegram_name%"
call :show-window "%visualstudio_name%"

echo end.
echo press any key to exit.
pause
exit

:check_and_run
set "program_name=%~1"
set "program_path=%~2"

tasklist /FI "IMAGENAME eq %program_name%" | find /I "%program_name%" >nul
if %errorlevel%==0 (
    echo %program_name% is already running.
) else (
    if exist "%program_path%" (
        echo Starting %program_name%...
        start "" "%program_path%"
        timeout /t 5 >nul
    ) else (
        echo %program_name% executable not found at %program_path%
    )
)
exit /b

:show-window
set "program_name=%~1"

echo try show window of %program_name%
:: some code for expanding the window
exit /b

endlocal