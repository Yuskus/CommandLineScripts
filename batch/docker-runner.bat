@echo off

setlocal enabledelayedexpansion

set "docker_path=C:\Program Files\Docker\Docker\Docker Desktop.exe"

tasklist /FI "IMAGENAME eq Docker Desktop.exe" | find /I "Docker Desktop.exe" >nul

if %errorlevel%==0 (
    goto :check-docker
) else (
    goto :run-docker
)

:run-docker
wsl --update
if exist "%docker_path%" (
    start "" "%docker_path%"
    timeout /t 10 >nul
)

:check-docker
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo docker-runner: docker is not running. please start docker and try again.
    exit /b 1
)

echo docker-runner: started

echo docker-runner: executing docker compose down
docker-compose down || (echo docker-compose down failed & exit /b 1)

echo docker-runner: executing docker compose build
docker-compose build || (echo docker-compose build failed & exit /b 1)

echo docker-runner: executing docker compose up
docker-compose up -d || (echo docker-compose up failed & exit /b 1)

echo docker-runner: ended

endlocal