# Temp Cleaner

Clear-Host

Write-Host "This will delete certain files, press Y to continue." -ForegroundColor Red
$confirm = Read-Host
if ($confirm -eq "Y") {

    $logPath = "$env:USERPROFILE\Desktop\CleanupLog.txt"
    Add-Content $logPath "=== Cleanup Log: $(Get-Date) ==="

    $totalBytesFreed = 0

    # --- TEMP FOLDER ---
    $tempPath = "$env:TEMP"
    $tempFiles = Get-ChildItem -Path $tempPath -Recurse -Force
    $tempSize = ($tempFiles | Measure-Object Length -Sum).Sum

    $total = $tempFiles.Count
    $counter = 0

    foreach ($file in $tempFiles) {
        $counter++
        Write-Progress -Activity "Cleaning Temp Folder" -Status "$counter of $total" -PercentComplete (($counter / $total) * 100)

        try {
            $size = if ($file.PSIsContainer) { 0 } else { $file.Length }
            Remove-Item $file.FullName -Force -Recurse -ErrorAction Stop
            $totalBytesFreed += $size
            Add-Content $logPath "Deleted: $($file.FullName)"
        } catch {
            Write-Host "Could not delete $($file.FullName)" -ForegroundColor Yellow
            Add-Content $logPath "Failed: $($file.FullName)"
        }
    }

    Write-Progress -Activity "Cleaning Temp Folder" -Completed
    Write-Host "Temp folder cleanup complete." -ForegroundColor Green
    Add-Content $logPath ("Temp Files Freed: {0:N2} MB" -f ($tempSize / 1MB))

# --- BIN RECYCLING ---
$binPath = [System.IO.Path]::Combine($env:SystemDrive, '$Recycle.Bin')
$binSize = (Get-ChildItem $binPath -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object Length -Sum).Sum
$totalBytesFreed += $binSize + $tempSize

Clear-RecycleBin -Force -ErrorAction SilentlyContinue
Add-Content $logPath "Recycle Bin emptied."
Write-Host "Recycle Bin cleanup complete." -ForegroundColor Green
Add-Content $logPath ("Recycle Bin Freed: {0:N2} MB" -f ($binSize / 1MB))

Add-Content $logPath ("Total Space Freed: {0:N2} MB ({1:N2} GB)" -f ($totalBytesFreed / 1MB), ($totalBytesFreed / 1GB))
Write-Host ("Total Space Freed: {0:N2} MB ({1:N2} GB)" -f ($totalBytesFreed / 1MB), ($totalBytesFreed / 1GB)) -ForegroundColor Cyan

} else {
    Clear-Host
    Write-Host "Cancelled" -ForegroundColor Green
}