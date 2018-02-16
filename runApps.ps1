param(
	[string]$configuration = "debug"
)

$allowedConfigurations = @("debug","release")
if (!$allowedConfigurations.Contains($configuration.ToLower())) {
	Write-Error "configuration must be one of the following values: $allowedConfigurations"
	exit
}

$packScriptPath = [System.IO.Path]::Combine($PSScriptRoot,"packApps.ps1")
Invoke-Expression "& `"$packScriptPath`" -configuration $configuration"

Write-Output "Running .NET Framework App"
$dnfAppPath = 
[System.IO.Path]::Combine($PSScriptRoot,"apps/DotNetFrameworkApp/DotNetFrameworkPluginApplication.exe")
Invoke-Expression "& `"$dnfAppPath`""
Write-Output ""

Write-Output "Running .NET Core App"
$dncAppPath = 
[System.IO.Path]::Combine($PSScriptRoot,"apps/DotNetCoreApp/DotNetCorePluginApplication.dll")
Invoke-Expression "& dotnet `"$dncAppPath`""
Write-Output ""