# Temp Cleaner

Clear-Host

Write-Host "This will delete certain files, press Y to continue." -ForegroundColor Red
$confirm = Read-Host
if ($confirm -eq "Y") {

    $logPath = "$env:USERPROFILE\Desktop\CleanupLog.txt"
    Add-Content $logPath "=== Cleanup Log: $(Get-Date) ==="

    $tempPath = "$env:TEMP"
    $tempFiles = Get-ChildItem -Path $tempPath -Recurse -Force

    $total = $tempFiles.Count
    $counter = 0

    foreach ($file in $tempFiles) {
        $counter++
        Write-Progress -Activity "Cleaning Temp Folder" -Status "$counter of $total" -PercentComplete (($counter / $total) * 100)

        try {
            Remove-Item $file.FullName -Force -Recurse -ErrorAction Stop
            Add-Content $logPath "Deleted: $($file.FullName)"
        } catch {
            Write-Host "Could not delete $($file.FullName)" -ForegroundColor Yellow
            Add-Content $logPath "Failed: $($file.FullName)"
        }
    }

    Write-Progress -Activity "Cleaning Temp Folder" -Completed
    Write-Host "Temp folder cleanup complete." -ForegroundColor Green

Clear-RecycleBin -Force -ErrorAction SilentlyContinue
Add-Content $logPath "Recycle Bin emptied."
Write-Host "Recycle Bin cleanup complete." -ForegroundColor Green

} else {
    Clear-Host
    Write-Host "Cancelled" -ForegroundColor Green
}