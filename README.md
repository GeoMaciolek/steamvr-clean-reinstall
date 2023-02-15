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

#### The Kinda-iffy Way

* Open [the link here](steamvr-clean-reinstall.ps1) in a new tab
* Select all & copy the text from the body/script of that
* Launch "PowerShell ISE" (included in most versions of windows)
  * Hit Windows
  * Type `ISE`
  * Click the appropriate link
* File - New
* Paste the script into the white window on top
* **Read Everything, Don't Run Strange Scripts From The Internet!**
* (If prompted to save, do not save)
* Hit F5 to run
* Observe output in the "Terminal" view at the bottom, and respond as needed.

#### The Proper Way

TODO: Add details on how to execute a powershell script!

* [Download steamvr-clean-reinstall.ps1](https://github.com/GeoMaciolek/steamvr-clean-reinstall/releases/download/0.1/steamvr-clean-reinstall.ps1)
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
  * Could also use the uninstall path from the same!

## Credits & Thanks

* [Alma's SteamVR clean Reinstall guide](https://steamcommunity.com/app/250820/discussions/2/1640917625015598552/)
* `@DenTechs` on the ["Virtual Desktop" Discord](https://discord.com/invite/mHtg4VfDfV)
  * Testing & noticing Windows Powershell compatibility issues
