@echo off
pushd %~dp0
title Ű��Ʈ�� �� ��Ʈ ����
rem echo Ű��Ʈ�� �� ��Ʈ�� �����մϴ�. ����Ͻðڽ��ϱ�?
rem pause
	
:main
echo.
echo.
echo.
echo     #1. GRF ���� ����
echo.
echo.
echo.
echo     #2. TAR ���� ����
echo.
echo.
echo.
set /P menu=��ȣ�� �Է����ּ���: 
cls
if "%MENU%"=="1" goto first_level
if "%MENU%"=="2" goto first_level
goto main

:first_level
echo.
echo #1. NFO ���� ������
echo �������� �����մϴ�.....
echo ����������������������������������������������������������
echo (1) NFO ���� ����
cd ..
echo ����������������������������������������������������������
nforenum newsta\sprites\newsta.nfo
echo.
echo (2) GRF ���� ����
echo ����������������������������������������������������������
grfcodec -e newsta\newsta.grf -g 2
cd newsta
echo ����������������������������������������������������������
echo.
echo.
echo.
if "%MENU%"=="1" goto copy_grf


echo #2. ���� ����
echo Ű��Ʈ�� �� ��Ʈ ���� ������ TAR ���Ϸ� �����մϴ�.
echo ���� �޽����� ���� �ʾҴٸ� ���࿡ ������ ���Դϴ�.
echo ����������������������������������������������������������
echo.
echo (1) Ű��Ʈ�� �� ��Ʈ ���� �ҷ�����
for /f "eol=; tokens=2 delims=:" %%i in (./custom_tags.txt) do (
	set KSS_VERSION=%%i
	goto out1
)

:out1
for /f "eol=; tokens=2 delims=: skip=1" %%i in (./custom_tags.txt) do (
	set KSS_REVISION=%%i
	goto out
)

:out
echo ����������������������������������������������������������
echo [���] ã�Ƴ� ����  : v%KSS_VERSION%
echo [���] ã�Ƴ� ������: r%KSS_REVISION%
echo ����������������������������������������������������������
echo.
echo.
echo.
echo (2) ����
echo ����������������������������������������������������������
if exist "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar" del "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar"
"%homedrive%Program Files\Bandizip\bc.exe" a "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar" "newsta.grf" "changelog.txt" "readme.txt"
echo ����������������������������������������������������������
echo.
echo.
echo.

:copy_grf
set /P WILL_YOU_COPY="�� ����/OpenTTD�� NewGRF�� �����Ͻðڽ��ϱ�? [Y/N] ..... "

if not exist %homedrive%%homepath%\documents\OpenTTD\ (
echo �� ����/OpenTTD�� �������� �ʽ��ϴ�.
goto stop_process
)

if %WILL_YOU_COPY% == y (
	if %MENU% == 1 (
		copy /Y newsta.grf %homedrive%%homepath%\documents\OpenTTD\NewGRF\newsta.grf
	)
	if %MENU% == 2 (
		copy /Y "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar" "%homedrive%%homepath%\documents\OpenTTD\NewGRF\newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar"
	)
)


echo.
echo.
echo.

:stop_process
set /P WILL_YOU_RETRY="�ٽ� ó������ �����Ͻðڽ��ϱ�? [Y/N] ..... "
if %WILL_YOU_RETRY% == y (
	cls
	goto main
)