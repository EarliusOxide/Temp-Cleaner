# Temp Cleaner

A PowerShell script to clean up temporary files and recycle bin contents on Windows.

## Features
- Cleans the `%TEMP%` folder  
- Empties the Recycle Bin  
- Logs deletions to the Desktop  
- Logs freed space to console and log file  

## Usage
1. Open PowerShell (Admin mode recommended).  
2. Run the script.  
3. Confirm deletion when prompted.  

> Note: Some temporary files may fail to delete if they are in use. Close all programs for maximum cleanup.

## Safety Tips / Notes
- The script **only deletes the user's temporary folder** and empties the **Recycle Bin**. Nothing else is touched.  
- A log file named `CleanupLog.txt` is created on the Desktop showing what was deleted, what failed, and the amount of space freed.  
- No modifications to the script are needed for it to work on other systems.  
- If PowerShell blocks script execution, run:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```