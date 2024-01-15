@ECHO OFF

ECHO ### WARNING ###
ECHO:
ECHO This batch file is going to start a PowerShell instance with 'Unrestricted' ExecutionPolicy
ECHO:
ECHO It will likely prompt you again to hit "R" in order to run if you have default security settings.
ECHO:
ECHO DO NOT continue if you have not reviewed both this file, and the script it executes for safety.
ECHO:

pause

pwsh.exe -ExecutionPolicy Unrestricted -File ptsd.ps1
