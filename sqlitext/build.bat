@echo off
call "%VS140COMNTOOLS%VsMSBuildCmd.bat" x64
msbuild.exe sqlext.sln /t:Build /p:Configuration=Release /p:Platform=x64
pause