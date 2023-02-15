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
        $SteamExePath = $SteamExePath,
        $SteamVRAppId = $SteamVRAppId,
        [boolean] $WhatIfSetting = $TestMode # "Inheret" testmode from main script
    )
    $SplatParams = @{}
    $SplatParams.WhatIf = $WhatIfSetting
    # Launch steam.exe, telling it to uninstall the requested app
    Start-Process -FilePath $SteamExePath -Wait -ArgumentList "steam://uninstall/$SteamVRAppId" @SplatParams
}

function Remove-ConfigFiles {
    Param(
        $ConfigFilesToRemove = $FilesToRemove,
        [boolean] $WhatIfSetting = $TestMode # "Inheret" testmode from main script
    )
    $SplatParams = @{}
    $SplatParams.WhatIf = $WhatIfSetting
    ForEach ($fileToRemove in $ConfigFilesToRemove) {
        if (Test-Path $fileToRemove) {
            If ($WhatIfSetting) {
                Write-Output "We would be removing $file"
            }
            Write-Verbose "Removing $fileToRemove"
            Remove-Item $fileToRemove @SplatParams
        } else {
            Write-Warning "File $fileToRemove does not exist, skipping"
        }
    }
}
# if $()
# ForEach ($file in $FilesToRemove) {
#     Write-Output "remove $file lol"
#     write-output "----"
# }