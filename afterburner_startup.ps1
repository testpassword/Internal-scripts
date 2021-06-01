$tasks = @()
$tasks[0] = "
if ("OK" -eq (Get-PnpDevice -FriendlyName 'NVIDIA GeForce GTX 1050').Status) {
    Start-Process -NoNewWindow -FilePath "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"
}"
$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
Register-ScheduledJob -Trigger $trigger -Action $tasks -Name AfterburnerAuto