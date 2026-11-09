param([switch]$Force)
Import-Module "$PSScriptRoot\lib\philh_myftp_biz\philh_myftp_biz.psm1" -Force
Invoke-AtPath $PSScriptRoot {

if ($Force) {
    Remove-Item "GemShock.rbxlx" -Force
    Remove-Item "lib\OpenRBLX\build" -Force -Recurse
    Remove-Item "lib\OpenRBLX\lib\luau\build" -Force -Recurse
}

$env:Path = "$PSScriptRoot\lib\w64devkit\bin;" + $env:Path

git.exe submodule update --init

if (-not (Test-Path "GemShock.rbxlx")) {
    & lib\argon.exe build -o "GemShock.rbxlx"
}

Invoke-AtPath "$PSScriptRoot\lib\OpenRBLX\lib\luau\build\release" {

    if (-not (Test-Path "libluau.a")) {

        make.exe config=release -C '..\..'

        ar.exe x libluauvm.a
        ar.exe x libluaucompiler.a
        ar.exe x libluauast.a
        ar.exe rcs libluau.a *.o

    }

};

make.exe `
    -C lib/OpenRBLX `
    PLATFORM=win64

};