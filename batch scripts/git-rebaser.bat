@echo off

setlocal enabledelayedexpansion

echo rebaser: you can set 1st parameter as "help" if you want more info about necessary parameters

if "%~1"=="help" (
    echo rebaser: it needs main branch name as parameter 1 and your current branch name as parameter 2
    echo rebaser: ended
    exit /b 1
)
if "%~1"=="" (
    echo rebaser: it needs main branch name as parameter 1
    echo rebaser: ended
    exit /b 1
)
if "%~2"=="" (
    echo rebaser: it needs your current branch name as parameter 2
    echo rebaser: ended
    exit /b 1
)

set "dev_branch=%~1" 
set "cur_branch=%~2"

for /f %%i in ('git stash list ^| find /c /v ""') do set "beforeStash=%%i"
echo rebaser: before stash - %beforeStash%

git stash
echo rebaser: stashed

for /f %%i in ('git stash list ^| find /c /v ""') do set "afterStash=%%i"
echo rebaser: after stash - %afterStash%

git checkout %dev_branch%
echo rebaser: you on branch %dev_branch%

git pull

git checkout %cur_branch%
echo rebaser: you on branch %cur_branch%

set "rebase_output="
for /f "delims=" %%i in ('git rebase %dev_branch% 2^>^&1') do (
    set "rebase_output=!rebase_output! %%i"
)

echo !rebase_output! | findstr /C:"pick" >nul
if !errorlevel! == 0 (
    echo rebaser: rebase entered interactive mode.
    echo rebaser: ended
    exit /b 1
)

if !afterStash! gtr !beforeStash! (
    git stash apply
    echo rebaser: stash apply
)

git status --porcelain
echo rebaser: ended

endlocal