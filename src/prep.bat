@echo off
set "_home=%~dp0"
cd /D "%_home%"
powershell -NoP .\wallpaper.ps1 "%_home%..\media\first.bmp"
