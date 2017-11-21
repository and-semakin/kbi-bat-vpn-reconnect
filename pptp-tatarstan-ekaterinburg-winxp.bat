@echo off
:Connect
rasdial /DISCONNECT
rasdial "vpn2.egov66.ru" login password
rasdial "vpn.tatarstan.ru" login password
route DELETE 10.0.0.0
route add 10.0.9.0 MASK 255.255.255.0 10.0.3.21 METRIC 1

ipconfig | grep -m 1 -E -o "10\.11\.[0-9]+\.[0-9]+" > temp.txt
set /p tat_ip=<temp.txt
route add 10.11.128.0 MASK 255.255.255.0 %tat_ip% METRIC 1

echo Connected.

ping 192.0.2.2 -n 1 -w 10000 > nul
:loop
	time /t
	echo ping Tatarstan
	ping 10.11.128.82 > nul || (
		echo Tatarstan failed.
		goto :Connect
	)
	echo ping Ekaterinburg
	ping 10.0.9.73 > nul || (
		echo Ekaterinburg failed.
		goto :Connect
	)
ping 192.0.2.2 -n 1 -w 30000 > nul
goto :loop
