## Start up fluff

## In the Powershell admn window, run the following command "Set-ExecutionPolicy Bypass". This will enable the script to run
param (
    [ValidateSet("-u", "-U", "-update", "true")]
    [switch]$Update = $false,
    [string]$Path = "$PSScriptRoot\apps.txt"
)

Write-host @"
    GameInstaller`n`n
    Install script for setting up a Gaming Environment
    Installing packages from Chocolatey and configuring everything you need`n
"@


if ($Update -or (-not (Test-Path $Path))) {
    Write-Host -ForegroundColor Cyan "Updating apps.txt..."
    $url_apps = "https://raw.githubusercontent.com/ThomasEdvardsen/esport/main/apps.txt"
    Invoke-WebRequest -Uri $url_apps -OutFile $Path
    Write-Host -ForegroundColor Green "apps.txt updated successfully."
}

Write-host -ForegroundColor "Yellow" "`n    Checking if Chocolatey is installed on the computer...`n"

If (Test-Path -Path "$env:ProgramData\Chocolatey") {
    Write-host -ForegroundColor "Green" "      Chocolatey is installed, moving on to packages`n"
}
else {
    Write-host  "     Chocolatey is not installed, starting installscript for Chocolatey`n"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

##
## Startup fluff over
##


# User responded "Install everything"
Write-host -ForegroundColor "Cyan" "`n------------------------------------------------------------------------------------`n"
Write-host -ForegroundColor "Cyan" "    Starting installation Process`n"
Write-host -ForegroundColor "Cyan" "------------------------------------------------------------------------------------`n"

$installFrom = "$PSSCriptRoot\apps.txt"

# Get all the apps from apps.txt file
$packages = Get-Content "$installFrom"

# Count how many applications are in the apps.txt file and relay this information to the user.
$count = Get-Content "$installFrom" | Measure-Object -Line
Write-host -ForegroundColor "Cyan" "`n    > Application list contains $count applications.`n"

# Loop through all the apps from apps.txt and install them with Chocolatey.
foreach ($line in $packages) {
    # Split the line into package name and parameters (if any)
    $packageName, $additionalParams = $line -split ' ', 2

    Write-host -ForegroundColor "Cyan" " Installing $packageName "

    # Install the package with Chocolatey along with additional parameters
    choco install $packageName $additionalParams -y
}

Write-host -ForegroundColor "Cyan" "------------------------------------------------------------------------------------"
Write-host -ForegroundColor "Cyan" "    Finished installation Process"
Write-host -ForegroundColor "Cyan" "------------------------------------------------------------------------------------`n"
