# Hent driverinfo om nyeste NVIDIA GeForce Game Ready (DCH, WHQL) for Windows 11 â€“ UK English
$r = Invoke-RestMethod 'https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=127&pfid=1023&osID=135&languageCode=1078&beta=0&isWHQL=0&dltype=-1&dch=1&upCRD=0&qnf=0&sort1=1&numberOfResults=1'
$info = $r.IDS[0].downloadInfo
$exeUrl = $info.DownloadURL
if (-not $exeUrl) { throw "DownloadURL mangler i responsen." }

$filename = Split-Path $exeUrl -Leaf
$dst = Join-Path $env:TEMP $filename

Write-Host "Versjon: $info.Version"
Write-Host "Fil:     $filename"
Write-Host "URL:     $exeUrl"

Write-Host "Laster ned med BITS til $dst ..."
Start-BitsTransfer -Source $exeUrl -Destination $dst

Write-Host "Installerer driver stille..."
#Start-Process $dst -ArgumentList "/s /noreboot" -Wait

Write-Host "Rydder opp..."
#Remove-Item $dst -Force

Write-Host "Ferdig."
