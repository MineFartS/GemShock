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

    if ((Get-ChildItem -Filter *.a).Length -lt 9) {

        make.exe config=release -C '..\..'

    }

};

make.exe `
    -C lib/OpenRBLX `
    PLATFORM=win64

};