@echo off

set DIR=C:\ProgramData\Milvus\Scripts
set SCRIPT=%DIR%\restart-milvus-service.ps1
set RAW=https://raw.githubusercontent.com/ben-dev-helpdesk/res_milvus/main/restart-milvus-service.ps1

mkdir %DIR% 2>nul

curl -L %RAW% -o %SCRIPT%

schtasks /Create ^
 /TN "Milvus Agent Service Restart" ^
 /SC HOURLY ^
 /MO 1 ^
 /RL HIGHEST ^
 /RU SYSTEM ^
 /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"%SCRIPT%\"" ^
 /F