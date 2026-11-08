@echo off
pushd "%~dp0"

set "Path=%~dp0\lib\w64devkit\bin;%Path%"

git submodule update --init

lib\argon build -o GemShock.rbxlx

rmdir /s /q "lib/OpenRBLX/build"

call :make

popd
goto :EOF

:make
    make.exe ^
        -C lib/OpenRBLX ^
        PLATFORM=win64 ^
        %*
    exit /b %ERRORLEVEL%

