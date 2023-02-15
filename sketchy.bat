@echo off
REM This is untested. Don't use it!

echo THIS WILL DELETE LOTS OF STUFF! DANGER! UNTESTED!
echo Press Control-C to exit if you're not sure you want to go ahead!
pause

echo Deleting config files.
del "C:\Program Files(x86)\Steam\steamapps\common\SteamVR\resources\settings\default.vrsettings"
del "C:\Program Files(x86)\Steam\config\steamvr.vrsettings"
del "C:\Program Files(x86)\Steam\config\lighthouse\lighthousedb.json"
echo Uninstalling

c:
cd "C:\Program Files (x86)\Steam"
steam.exe steam://uninstall/250820

echo Removing SteamVR Folder

rd /s /q "C:\Program Files(x86)\Steam\Steamapps\common\SteamVR"

echo Installing steam
steam.exe steam://install/250820

echo Done!
pause
