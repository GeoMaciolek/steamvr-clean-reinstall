Param(
	[array]
    $FilesToRemove = @(
        "C:\Program Files (x86)\Steam\steamapps\common\SteamVR\resources\settings\default.vrsettings",
	    "C:\Program Files (x86)\Steam\config\steamvr.vrsettings",
        "C:\Program Files (x86)\Steam\config\lighthouse\lighthousedb.json"),
    [int32]
    $SteamVRAppId = 250820,
    [boolean]
	$TestMode = $true
)

