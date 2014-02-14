@echo off
SET SCRIPTS_DIR=%~dp0

START /B %SCRIPTS_DIR%\..\player\bin\win32\quick-x-player.exe -workdir %SCRIPTS_DIR%\ -file %SCRIPTS_DIR%\scripts\main.lua -size 960x640
