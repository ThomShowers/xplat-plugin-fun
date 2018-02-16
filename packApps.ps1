param(
	[string]$configuration = "debug"
)

$allowedConfigurations = @("debug","release")
if (!$allowedConfigurations.Contains($configuration.ToLower())) {
	Write-Error "configuration must be one of the following values: $allowedConfigurations"
	exit
}

$dnfAppBuildPath = 
	[System.IO.Path]::Combine(
		$PSScriptRoot, "DotNetFrameworkPluginApplication\bin", $configuration)
$dnfPluginBuildPath = 
	[System.IO.Path]::Combine(
		$PSScriptRoot, "DotNetFrameworkPluginImplementation\bin", $configuration)
$dncAppBuildPath = 
	[System.IO.Path]::Combine(
		$PSScriptRoot, "DotNetCorePluginApplication\bin", $configuration, "netcoreapp2.0")
$dncPluginBuildPath = 
	[System.IO.Path]::Combine(
		$PSScriptRoot, "DotNetCorePluginImplementation\bin", $configuration, "netcoreapp2.0")


$appsDir = [System.IO.Path]::Combine($PSScriptRoot, "apps")
if (Test-Path $appsDir) { rm -recurse -force $appsDir }
mkdir $appsDir | Out-Null

$dnfAppDir = [System.IO.Path]::Combine($appsDir, "DotNetFrameworkApp")
mkdir $dnfAppDir | Out-Null
gci -r -include "*.dll","*.exe" $dnfAppBuildPath |% { cp $_ $dnfAppDir }
gci -r -include "*.dll","*.exe" $dnfPluginBuildPath |% { cp $_ $dnfAppDir }

$dncAppDir = [System.IO.Path]::Combine($appsDir, "DotNetCoreApp")
mkdir $dncAppDir | Out-Null
gci -r -include "*.dll","*.exe","*.json" $dncAppBuildPath |% { cp $_ $dncAppDir }
gci -r -include "*.dll","*.exe" $dncPluginBuildPath |% { cp $_ $dncAppDir }
gci -r -include "*.dll","*.exe" $dnfPluginBuildPath |% { cp $_ $dncAppDir }