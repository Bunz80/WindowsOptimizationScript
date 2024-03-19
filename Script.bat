@echo off
SETLOCAL EnableExtensions
REM Path: C:\Users\TuoNome\Documents\

echo Inizio dell'ottimizzazione di Windows...

REM Disabilita servizi non essenziali
echo Disabilitando servizi non essenziali...
for %%s in (DiagTrack dmwappushservice wuauserv Fax XboxGipSvc) do (
    sc config "%%s" start= disabled
    sc stop "%%s"
)

REM Elimina file temporanei
echo Eliminando file temporanei...
del /q /f /s %temp%\* && del /q /f /s %windir%\temp\*

REM Disabilitazione applicazioni in background
echo Disabilitando applicazioni in background...
PowerShell -Command "Get-AppxPackage | Where-Object {$_.IsFramework -eq $False} | ForEach-Object {Set-AppXPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}"

REM Disabilitare elementi di avvio non necessari (esempio: Skype)
echo Disabilitando elementi di avvio non necessari...
PowerShell -Command "Get-CimInstance Win32_StartupCommand | Where-Object {$_.Name -eq 'Skype'} | Disable-CimInstance"

echo Ottimizzazione completata.
pause
