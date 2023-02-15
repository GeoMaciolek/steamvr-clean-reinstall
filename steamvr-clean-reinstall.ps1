Param(
	[array]
    $FilesToRemove = @(
        'C:\Program Files (x86)\Steam\steamapps\common\SteamVR\resources\settings\default.vrsettings',
        'C:\Program Files (x86)\Steam\config\steamvr.vrsettings',
        'C:\Program Files (x86)\Steam\config\lighthouse\lighthousedb.json'),
    [int32]
    $SteamVRAppId = 250820,
    [string]
    $SteamExePath = 'C:\Program Files (x86)\Steam\steam.exe',
    [boolean]
	$TestMode = $true
)

function Remove-SteamApp {
    Param(
        $SteamExePath = $SteamExePath,
        $SteamVRAppId = $SteamVRAppId
    )

    # Launch steam.exe, telling it to uninstall the requested app
    Start-Process -FilePath $SteamExePath -Wait -ArgumentList "steam://uninstall/$SteamVRAppId"
}