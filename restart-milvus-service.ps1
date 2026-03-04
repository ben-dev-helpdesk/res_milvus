@echo on
setlocal

set "DIR=C:\ProgramData\Milvus\Scripts"
set "SCRIPT=%DIR%\restart-milvus-service.ps1"
set "RAW=https://raw.githubusercontent.com/ben-dev-helpdesk/res_milvus/main/restart-milvus-service.ps1"
set "LOG=%DIR%\install.log"

mkdir "%DIR%" 2>nul

echo ===== INICIO INSTALL %DATE% %TIME% =====>> "%LOG%"

echo Baixando script...>> "%LOG%"
curl -L "%RAW%" -o "%SCRIPT%" >> "%LOG%" 2>&1

echo Criando tarefa...>> "%LOG%"
schtasks /Create /TN "\Milvus Agent Service Restart" /SC HOURLY /MO 1 /RL HIGHEST /RU SYSTEM /F ^
 /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File ""%SCRIPT%""" >> "%LOG%" 2>&1

echo Consultando tarefa...>> "%LOG%"
schtasks /Query /TN "\Milvus Agent Service Restart" /FO LIST /V >> "%LOG%" 2>&1

echo ===== FIM INSTALL %DATE% %TIME% =====>> "%LOG%"

echo Instalacao finalizada. Log em: %LOG%
pause