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

Param(
    [string]
    $SteamPath = ${env:ProgramFiles(x86)} + '\Steam',
	[array]
    $FilesToRemove = @(
        "$SteamPath\steamapps\common\SteamVR\resources\settings\default.vrsettings";
        "$SteamPath\Steam\config\steamvr.vrsettings";
        "$SteamPath\config\lighthouse\lighthousedb.json"),
    [int32]
    $SteamVRAppId = 250820,
    [string]
    $SteamVRInstallPath = "$SteamPath\Steamapps\common\SteamVR", # Assumption here!
    [string]
    $SteamExePath = "$SteamPath\steam.exe",
    [boolean]
    $InteractivePrompts = $true, # Ask user if we really want to do this first (and pause at end)
    [boolean]
	$TestMode = $false
)

function Remove-SteamApp {
    Param(
        [string] $SteamExePath,
        [int32] $SteamAppId,
        [boolean] $WhatIf
    )
    $SplatParams = @{}
    $SplatParams.WhatIf = $WhatIf
    # Launch steam.exe, telling it to uninstall the requested app
    Start-Process -FilePath $SteamExePath -Wait -ArgumentList "steam://uninstall/$SteamAppId" @SplatParams
}

function Add-SteamApp {
    Param(
        [string] $SteamExePath,
        [int32] $SteamAppId,
        [boolean] $WhatIf = $false
    )
    $SplatParams = @{}
    $SplatParams.WhatIf = $WhatIf
    # Launch steam.exe, telling it to uninstall the requested app
    Start-Process -FilePath $SteamExePath -Wait -ArgumentList "steam://install/$SteamAppId" @SplatParams
}

function Remove-SteamAppFolder {
    Param(
        [string] $SteamAppFolder,
        [boolean] $WhatIf = $false
    )
    if ($WhatIf) {
        Write-Output "We would be removing everything in $SteamAppFolder!"
    }
    $SplatParams = @{}
    $SplatParams.WhatIf = $WhatIf
    if (Test-Path $SteamAppFolder) {
        Write-Verbose "Removing $SteamAppFolder"
        Remove-Item -Recurse -Path $SteamAppFolder @SplatParams
    } else {
        Write-Warning "Folder not found, so not deleted:`n$SteamAppFolder"
    }
}

function Remove-ConfigFiles {
    Param(
        [array] $ConfigFilesToRemove,
        [boolean] $WhatIf = $false
    )
    $SplatParams = @{}
    $SplatParams.WhatIf = $WhatIf
    ForEach ($fileToRemove in $ConfigFilesToRemove) {
        if (Test-Path $fileToRemove) {
            If ($WhatIf) {
                Write-Output "We would be removing $file"
            }
            Write-Verbose "Removing $fileToRemove"
            Remove-Item $fileToRemove @SplatParams
        } else {
            Write-Warning "File $fileToRemove does not exist, skipping"
        }
    }
}

If ($InteractivePrompts) {
    Write-Warning "THIS SCRIPT DELETES FILES! BE CAREFUL!"
    Read-Host -Prompt @"
### WARNING! ###
This script is about to delete everything in:
$SteamVRInstallPath

This script does not perform any backups, may have errors, and comes with no
warranty. If you are not ABSOLUTELY CERTAIN you want to delete files, Press
"Control-C" now, or close this window!

Otherwise, press [Enter] to continue...
"@

if (($input.ToUpper() -eq 'Q') -or ($null -eq $input)) {
    Write-Warning "Exiting..."
    exit 1
}
}

Write-Output "Removing config files..."
Remove-ConfigFiles -ConfigFilesToRemove $FilesToRemove -WhatIf $TestMode

Write-Output "Uninstalling SteamVR..."
Remove-SteamApp -SteamExePath $SteamExePath -SteamAppId $SteamVRAppId -WhatIf $TestMode

Write-Output "Removing SteamVR Install folder..."
Remove-SteamAppFolder -SteamAppFolder $SteamVRInstallPath -WhatIf $TestMode

Write-Output "Installing SteamVR..."
Add-SteamApp -SteamExePath $SteamExePath -SteamAppId $SteamVRAppId -WhatIf $TestMode

If ($InteractivePrompts) {
    Read-Host -Prompt "Press Enter to exit"
}
