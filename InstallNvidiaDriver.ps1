# Hent driverinfo om nyeste NVIDIA GeForce Game Ready (DCH, WHQL) for Windows 11 â€“ UK English
$r = Invoke-RestMethod 'https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=127&pfid=1023&osID=135&languageCode=1078&beta=0&isWHQL=0&dltype=-1&dch=1&upCRD=0&qnf=0&sort1=1&numberOfResults=1'
$info = $r.IDS[0].downloadInfo
$version = $info.Version
$downloadUrl = $info.DownloadURL
if (-not $downloadUrl) { throw "DownloadURL mangler i responsen." }

$filename = Split-Path $downloadUrl -Leaf
$dst = Join-Path $env:TEMP $filename

Write-Host "Versjon: GeForce Game Ready Driver $version"
Write-Host "URL:     $downloadUrl"

$old = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'

Write-Host "Downloading driver $version to $dst ..."
Invoke-WebRequest -Uri "$downloadUrl" -OutFile "$dst"
$ProgressPreference = $old

Write-Host "Installing driver silent..."
$proc = Start-Process -FilePath $dst -ArgumentList "-s -noreboot" -Wait -PassThru
Write-Host "Install exitkode: $($proc.ExitCode)"
if ($proc.ExitCode -eq 0) {
    Write-Host "Installation finished. Please restart your PC."
} else {
    Write-Warning "Installation failed or gave a warning (ExitCode: $($proc.ExitCode)). Check NVIDIA-logs in %ProgramData%."
}

Write-Host "Cleaning up..."
Remove-Item $dst -Force

Write-Host "Finished."
