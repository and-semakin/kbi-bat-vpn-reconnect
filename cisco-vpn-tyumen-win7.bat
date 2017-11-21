@echo off
cd /d "C:\Program Files (x86)\VPNC Front End"
:loop
    time /t
        echo ping 10.12.158.27
    ping 10.12.158.27 >nul || (
        echo ping failure - killing vpnc
        Taskkill /f /IM vpnc.exe
        Taskkill /f /IM vpnc-fe.exe
        timeout /t 10 /nobreak
        echo starting vpnc
        start vpnc-fe.exe
        timeout /t 15 /nobreak
   )
timeout /t 15 /nobreak
goto :loop
