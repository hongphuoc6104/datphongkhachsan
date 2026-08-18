@echo off
chcp 65001 >nul

echo ========================================================
echo   HE THONG DAT PHONG KHACH SAN (DATPHONG)
echo ========================================================
echo.

if exist "%LOCALAPPDATA%\Programs\DockerDesktop\resources\bin\docker.exe" set "PATH=%LOCALAPPDATA%\Programs\DockerDesktop\resources\bin;%PATH%"
if exist "%ProgramFiles%\Docker\Docker\resources\bin\docker.exe" set "PATH=%ProgramFiles%\Docker\Docker\resources\bin;%PATH%"

where docker >nul 2>&1
if errorlevel 1 goto :no_docker

docker compose version >nul 2>&1
if errorlevel 1 goto :no_compose

docker info >nul 2>&1
if errorlevel 1 goto :no_daemon

echo [OK] Docker Engine da san sang.
echo Dang khoi dong cac dich vu (MySQL, MongoDB rs0, Redis, Backend, Realtime, Frontend)...
echo.
echo Website se san sang tai:
echo   - Frontend: http://localhost:3000
echo   - Backend API: http://localhost:8000/api/v1
echo.

docker compose up --build
if errorlevel 1 goto :compose_error
exit /b 0

:no_docker
echo [LOI] Khong tim thay Docker trong he thong!
echo Vui long cai dat Docker Desktop tai: https://www.docker.com/products/docker-desktop/
echo Hoac mo Docker Desktop neu da cai dat.
pause
exit /b 1

:no_compose
echo [LOI] Docker Compose khong san sang!
echo Vui long cap nhat Docker Desktop len phien ban moi nhat.
pause
exit /b 1

:no_daemon
echo [CANH BAO] Docker Desktop chua duoc khoi dong hoac Engine chua san sang!
echo Vui long mo ung dung Docker Desktop tren Windows va cho den khi co bieu tuong mau xanh (Engine running).
pause
exit /b 1

:compose_error
echo [LOI] Co loi xay ra trong qua trinh khoi dong Docker Compose.
pause
exit /b 1
