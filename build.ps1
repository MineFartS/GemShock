Push-Location $PSScriptRoot

$env:Path = "$PSScriptRoot\lib\w64devkit\bin;" + $env:Path

git.exe submodule update --init

& lib\argon.exe build -o GemShock.rbxlx

Remove-Item "lib/OpenRBLX/build" -Force -Recurse

make.exe `
    -C lib/OpenRBLX `
    PLATFORM=win64

Pop-Location