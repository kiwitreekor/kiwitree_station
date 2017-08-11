@echo off
pushd %~dp0
title Ű��Ʈ�� �� ��Ʈ ���� v0.2

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
echo ����������������������������������������������������������
..\nforenum sprites\kws_new1.nfo
echo.
echo (2) GRF ���� ����
echo ����������������������������������������������������������
..\grfcodec -e kws_new1.grf -g 2 -n
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
	set KWS_VERSION=%%i
	goto out1
)

:out1
for /f "eol=; tokens=2 delims=: skip=1" %%i in (./custom_tags.txt) do (
	set KWS_REVISION=%%i
	goto out
)

:out
echo ����������������������������������������������������������
echo [���] ã�Ƴ� ����  : v%KWS_VERSION%
echo [���] ã�Ƴ� ������: r%KWS_REVISION%
echo ����������������������������������������������������������
echo.
echo.
echo.
echo (2) ����
echo ����������������������������������������������������������
if exist "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" (
	ren "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar.bak"
)
"C:\Program Files\Bandizip\bc.exe" a "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" "kws_new1.grf" "changelog.txt" "readme.txt"
echo ����������������������������������������������������������
echo.
echo.
echo.

:copy_grf

if not exist %homedrive%%homepath%\documents\OpenTTD\ (
echo �� ����/OpenTTD�� �������� �ʽ��ϴ�.
goto stop_process
)

if %MENU% == 1 (
	copy /Y kws_new1.grf %homedrive%%homepath%\documents\OpenTTD\NewGRF\kws_new1.grf
)
if %MENU% == 2 (
		copy /Y "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" "%homedrive%%homepath%\documents\OpenTTD\NewGRF\kws_v%KWS_VERSION%_r%KWS_REVISION%.tar"
)


echo.
echo.
echo.

:stop_process
set /P WILL_YOU_RETRY="�ٽ� ó������ �����Ͻðڽ��ϱ�? [Y/N] ..... "
if %WILL_YOU_RETRY% == y (
	goto retry
)
if %WILL_YOU_RETRY% == Y (
	goto retry
)

goto exit

:retry
cls
goto main

:exit