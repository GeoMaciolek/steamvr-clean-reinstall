# SteamVR Clean Reinstall

## Overview

This tool helps you do a clean reinstall of SteamVR. It is under development,
is largely untested, and should be used with caution.

## Using the tool

### Warnings

This script WILL delete files on your computer, and may do so in unexpected
ways, especially if you make any configuration changes, or if you have Steam
or SteamVR installed in unusual locations. Use this at your own risk!

Additionally, this will require you to re-download SteamVR, a 3.2 GB download
as of 2022-02-14. Consider this before using this tool, especially if you use
metered internet or have a slow connection.

### How To Run

TODO: Add details on how to execute a powershell script!

* Download [steamvr-clean-reinstall.ps1](https://raw.githubusercontent.com/GeoMaciolek/steamvr-clean-reinstall/main/steamvr-clean-reinstall.ps1) (Right-click, "Save link as...")
* Run the above

## How It Works

### Script Overview

(You may wish to simply [View the script](steamvr-clean-reinstall.ps1) to understand more)

* Deletes several SteamVR settings files
* Uninstalls SteamVR (by calling `steam.exe`)
* Deletes the steamvr install folder
* Installs SteamVR (by calling `steam.exe`)

### Sample Help Test

```powershell
<#
.SYNOPSIS
    Clean reinstall of SteamVR
.DESCRIPTION
    This script uninstalls SteamVR, deletes various files, and reinstalls SteamVR
.NOTES
    Use this at your own risk!
.LINK
    https://github.com/GeoMaciolek/steamvr-clean-reinstall
.EXAMPLE
    .\steamvr-clean-reinstall.ps1
    Runs with all typical defaults.
.EXAMPLE
    .\steamvr-clean-reinstall.ps1 -SteamVRInstallPath 'C:\SomeOtherSteamVRPath'
#>
```

## Issues & To-do

* Makes certain assumptions about install folders
  * This should be OK for SteamVR, but not for other games/apps if needed
  * Could read `InstallLocation` from `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 250820`

## Credits & Thanks

* [Alma's SteamVR clean Reinstall guide](https://steamcommunity.com/app/250820/discussions/2/1640917625015598552/)
* `@DenTechs` on the ["Virtual Desktop" Discord](https://discord.com/invite/mHtg4VfDfV)
  * Testing & noticing Windows Powershell compatibility issues
