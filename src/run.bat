@echo off
setlocal enabledelayedexpansion
if not [%1]==[ch] (start conhost cmd /c "" "%~dpnx0" ch & exit)
powershell -NoP -W hidden ; exit
set "_home=%~dp0"
cd /D "%_home%"

powershell -NoP .\wallpaper.ps1 "%_home%..\media\first.bmp"

for /f "tokens=3 delims= " %%i in ('wmic path Win32_VideoController get CurrentHorizontalResolution^,CurrentVerticalResolution ^| findstr /r /c:"^[0-9]"') do (
  set "MONITOR_WIDTH=%%i"
  set "MONITOR_HEIGHT=%%j"
)

timeout 1
start /B ..\mpv\mpv ..\media\bloom.mp4 --geometry=!MONITOR_WIDTH!x!MONITOR_HEIGHT!  --no-osc --no-input-default-bindings --no-taskbar-progress --no-window-dragging ^
    --deband --hwdec=auto --no-border --cache=yes --demuxer-max-bytes=488281KiB --demuxer-readahead-secs=6 --autofit=100%% --player-operation-mode=pseudo-gui --input-ipc-server=\\.\pipe\mpvsocket --force-window=yes --volume=0
cd ..\src
timeout 2
powershell -NoP .\wallpaper.ps1 "%_home%..\media\last.bmp"
