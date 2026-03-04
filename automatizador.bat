@echo off

set DIR=C:\ProgramData\Milvus\Scripts
set SCRIPT=%DIR%\restart-milvus-service.ps1
set RAW=https://raw.githubusercontent.com/ben-dev-helpdesk/res_milvus/main/restart-milvus-service.ps1

echo Criando pasta segura...
mkdir %DIR% 2>nul

echo Baixando script do GitHub...
curl -L %RAW% -o %SCRIPT%

echo Criando tarefa agendada...

schtasks /Create ^
 /TN "Milvus Agent Service Restart" ^
 /SC HOURLY ^
 /MO 1 ^
 /RL HIGHEST ^
 /RU SYSTEM ^
 /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"%SCRIPT%\"" ^
 /F

echo.
echo Instalacao concluida.
echo O servico sera reiniciado a cada 1 hora.
pause