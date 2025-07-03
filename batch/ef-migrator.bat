@echo off

setlocal enabledelayedexpansion

set "migration_name=______"

if "%~1"=="help" (
    echo ef-migrator: you can input name of your new migration as first parameter or do nothing.
    exit /b 1
)
if NOT "%~1"=="" (
    set "migration_name=%~1"
)

set "current_dir=%cd%"
set "db_conn_value="
set "program_directory="
set "migrations_directory="

for /r %%a in (*) do (
    if "%%~nxa"=="docker-compose.yml" (
        for /f "tokens=*" %%l in ('findstr /i "DB_CONN" "%%~nxa"') do (
            set "db_conn_value=%%l"
            set "db_conn_value=!db_conn_value:~0!"
            goto :next_step
        )
    )
)

:next_step
if not defined db_conn_value (
    echo DB_CONN not found in any docker-compose.yml file.
    exit /b 1
)

for /r %%a in (*) do (
    if "%%~nxa"=="Program.cs" (
        set "program_directory=%%~dpa"
        goto :next_step2
    )
)

:next_step2
if not defined program_directory (
    echo Program.cs not found in any directory.
    exit /b 1
)

for /d /r %%d in (Migrations) do (
    if exist "%%d*" (
        set "migrations_directory=%%~dpd"
        goto :end
    )
)

:end
if not defined migrations_directory (
    echo Migrations directory not found in any directory.
    exit /b 1
)

set "result_db_conn=!db_conn_value:~9!"
set "result_program_directory=.!program_directory:%current_dir%=!"
set "result_migrations_directory=.!migrations_directory:%current_dir%=!"

echo ef-migrator found your parameters:
echo connection string: !result_db_conn!
echo program directory: !result_program_directory!
echo migrations folder: !result_migrations_directory!

echo here is your strings (you can copy it):
echo dotnet ef migrations add "!migration_name!" -s "!result_program_directory!" -p "!result_migrations_directory!"
echo dotnet ef database update -s "!result_program_directory!" -p "!result_migrations_directory!" --connection "!result_db_conn!"

endlocal