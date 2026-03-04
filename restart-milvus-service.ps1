$serviceName = "Milvus.Helpdesk.Agente.ServiceCore"
$logDir = "C:\ProgramData\Milvus\Scripts"
$logPath = Join-Path $logDir "milvus-agent-monitor.log"

if (!(Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

function Log($msg) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $msg
    Add-Content -Path $logPath -Value $line -Encoding UTF8
}

try {
    $svc = Get-Service -Name $serviceName -ErrorAction Stop
} catch {
    Log "ERRO: serviço não encontrado: $serviceName | $_"
    exit 2
}

Log "Status atual: $($svc.Status)"

if ($svc.Status -eq "Running") {
    Log "OK: serviço já está rodando. Nenhuma ação necessária."
    exit 0
}

# Se estiver parado/pausado/etc, tenta iniciar
try {
    Log "Serviço não está Running. Tentando iniciar..."
    Start-Service -Name $serviceName -ErrorAction Stop
    Start-Sleep -Seconds 3

    $svc = Get-Service -Name $serviceName
    Log "Status após Start: $($svc.Status)"

    if ($svc.Status -ne "Running") {
        Log "WARN: não ficou Running após Start. Tentando Restart..."
        Restart-Service -Name $serviceName -Force -ErrorAction Stop
        Start-Sleep -Seconds 3
        $svc = Get-Service -Name $serviceName
        Log "Status após Restart: $($svc.Status)"
    }

    if ($svc.Status -eq "Running") {
        Log "SUCESSO: serviço está Running."
        exit 0
    } else {
        Log "FALHA: serviço não ficou Running."
        exit 1
    }
}
catch {
    Log "ERRO ao corrigir serviço: $_"
    exit 1
}