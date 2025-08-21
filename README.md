# Temp Cleaner

A PowerShell script to clean up temporary files and recycle bin contents on Windows.

## Features
- Cleans `%TEMP%` folder
- Empties recycle bin
- Logs deletions to Desktop

## Usage
Run the script in PowerShell, if it doesn't work, run it on admin mode
Confirm deletion when prompted
Mass failures are not a problem, certain temporary files are required to keep programs running, and deleting will be skipped
If you want to delete these files, close all programs, then run the script
