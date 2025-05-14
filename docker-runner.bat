@echo off

setlocal enabledelayedexpansion

docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo error: docker is not running. please start docker and try again.
    exit /b 1
)

echo docker-runner started

echo executing dotnet build
dotnet build

echo executing docker compose down
docker-compose down

echo executing docker compose build without cache
docker-compose build --no-cache

echo executing docker compose up
docker-compose up

echo docker-runner ended

endlocal