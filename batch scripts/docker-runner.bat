@echo off

setlocal enabledelayedexpansion

docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo docker-runner: docker is not running. please start docker and try again.
    exit /b 1
)

echo docker-runner: started

echo docker-runner: executing dotnet build
dotnet build

echo docker-runner: executing docker compose down
docker-compose down

echo docker-runner: executing docker compose build (without cache)
docker-compose build --no-cache

echo docker-runner: executing docker compose up
docker-compose up -d

echo docker-runner: ended

endlocal