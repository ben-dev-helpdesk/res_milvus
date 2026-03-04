$DIR = "C:\ProgramData\Milvus\Scripts"
$SCRIPT = "$DIR\restart-milvus-service.ps1"
$RAW = "https://raw.githubusercontent.com/ben-dev-helpdesk/res_milvus/main/restart-milvus-service.ps1"

# criar pasta
New-Item -ItemType Directory -Path $DIR -Force | Out-Null

# baixar script principal
Invoke-WebRequest $RAW -OutFile $SCRIPT

# criar tarefa
schtasks /Create `
 /TN "\Milvus Agent Service Restart" `
 /SC HOURLY `
 /MO 1 `
 /RL HIGHEST `
 /RU SYSTEM `
 /TR "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$SCRIPT`"" `
 /F