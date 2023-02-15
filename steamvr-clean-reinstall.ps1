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
    $SteamExePath = "$SteamPath\steam.exe",
    [boolean]
	$TestMode = $true
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

function Remove-ConfigFiles {
    Param(
        [array] $ConfigFilesToRemove,
        [boolean] $WhatIf
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

Write-Verbose "Removing config files..."
Remove-ConfigFiles -ConfigFilesToRemove $FilesToRemove -WhatIf $TestMode

Write-Verbose "Uninstalling SteamVR..."
Remove-SteamApp -SteamExePath $SteamExePath -SteamAppId $SteamVRAppId -WhatIf $TestMode

