@echo off

setlocal enabledelayedexpansion

echo you can set 1st parameter as "help" if you want more info about necessary parameters.

if "%~1"=="help" (
    echo it needs main branch name as parameter 1 and your current branch name as parameter 2.
    exit /b 1
)
if "%~1"=="" (
    echo it needs main branch name as parameter 1.
    exit /b 1
)
if "%~2"=="" (
    echo it needs your current branch name as parameter 2.
    exit /b 1
)

set "dev_branch=%~1" 
set "cur_branch=%~2" 
set "changed_files=0"

echo main branch from which rebase will be made: %dev_branch%
echo your branch to which rebase will be made: %cur_branch%

for /f "tokens=1" %%A in ('git status --porcelain') do (
    if "%%A"==" M" set "changed_files=1" 
)

if !changed_files! == 1 (
    git stash
    echo stashed
)

set "output_from_pull="

for /f "delims=" %%i in ('git pull 2^>^&1') do (
    set "output_from_pull=%%i"
)

echo !output_from_pull! | findstr /C:"up to date" >nul
if !errorlevel! == 0 (
    echo repository is already up to date.
    exit /b 1
)

git checkout %dev_branch%

echo you on branch %dev_branch%

git pull                     
git checkout %cur_branch%

echo you on branch %cur_branch%

set "rebase_output="
for /f "delims=" %%i in ('git rebase %dev_branch% 2^>^&1') do (
    set "rebase_output=!rebase_output! %%i"
)

echo !rebase_output! | findstr /C:"pick" >nul
if !errorlevel! == 0 (
    echo rebase entered interactive mode.
    exit /b 1
)

if !changed_files! == 1 (
    git stash apply
    echo stash apply
)

git status
echo ended

endlocal