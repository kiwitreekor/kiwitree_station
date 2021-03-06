@echo off
pushd %~dp0
title 키위트리 역 세트 빌드 v0.2

:main
echo.
echo.
echo.
echo     #1. GRF 파일 생성
echo.
echo.
echo.
echo     #2. TAR 파일 생성
echo.
echo.
echo.
set /P menu=번호를 입력해주세요: 
cls
if "%MENU%"=="1" goto first_level
if "%MENU%"=="2" goto first_level
goto main

:first_level
echo.
echo #1. NFO 파일 컴파일
echo 컴파일을 실행합니다.....
echo ─────────────────────────────
echo (1) NFO 파일 정렬
echo ─────────────────────────────
..\nforenum sprites\kws_new1.nfo
echo.
echo (2) GRF 파일 생성
echo ─────────────────────────────
..\grfcodec -e kws_new1.grf -g 2 -n
echo ─────────────────────────────
echo.
echo.
echo.
if "%MENU%"=="1" goto copy_grf


echo #2. 파일 압축
echo 키위트리 역 세트 관련 파일을 TAR 파일로 압축합니다.
echo 오류 메시지가 뜨지 않았다면 압축에 성공한 것입니다.
echo ─────────────────────────────
echo.
echo (1) 키위트리 역 세트 버전 불러오기
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
echo ─────────────────────────────
echo [결과] 찾아낸 버전  : v%KWS_VERSION%
echo [결과] 찾아낸 리비전: r%KWS_REVISION%
echo ─────────────────────────────
echo.
echo.
echo.
echo (2) 압축
echo ─────────────────────────────
if exist "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" (
	ren "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar.bak"
)
"C:\Program Files\Bandizip\bc.exe" a "kws_v%KWS_VERSION%_r%KWS_REVISION%.tar" "kws_new1.grf" "changelog.txt" "readme.txt"
echo ─────────────────────────────
echo.
echo.
echo.

:copy_grf

if not exist %homedrive%%homepath%\documents\OpenTTD\ (
echo 내 문서/OpenTTD가 존재하지 않습니다.
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
set /P WILL_YOU_RETRY="다시 처음부터 시작하시겠습니까? [Y/N] ..... "
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