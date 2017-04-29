@echo off
pushd %~dp0
title 키위트리 역 세트 빌드
rem echo 키위트리 역 세트를 빌드합니다. 계속하시겠습니까?
rem pause
	
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
cd ..
echo ─────────────────────────────
nforenum newsta\sprites\newsta.nfo
echo.
echo (2) GRF 파일 생성
echo ─────────────────────────────
grfcodec -e newsta\newsta.grf -g 2
cd newsta
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
	set KSS_VERSION=%%i
	goto out1
)

:out1
for /f "eol=; tokens=2 delims=: skip=1" %%i in (./custom_tags.txt) do (
	set KSS_REVISION=%%i
	goto out
)

:out
echo ─────────────────────────────
echo [결과] 찾아낸 버전  : v%KSS_VERSION%
echo [결과] 찾아낸 리비전: r%KSS_REVISION%
echo ─────────────────────────────
echo.
echo.
echo.
echo (2) 압축
echo ─────────────────────────────
if exist "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar" del "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar"
"%homedrive%Program Files\Bandizip\bc.exe" a "newsta_v%KSS_VERSION%_r%KSS_REVISION%.tar" "newsta.grf" "changelog.txt" "readme.txt"
echo ─────────────────────────────
echo.
echo.
echo.

:copy_grf
set /P WILL_YOU_COPY="내 문서/OpenTTD에 NewGRF를 복사하시겠습니까? [Y/N] ..... "

if not exist %homedrive%%homepath%\documents\OpenTTD\ (
echo 내 문서/OpenTTD가 존재하지 않습니다.
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
set /P WILL_YOU_RETRY="다시 처음부터 시작하시겠습니까? [Y/N] ..... "
if %WILL_YOU_RETRY% == y (
	cls
	goto main
)