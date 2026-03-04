$serviceName = "Milvus.Helpdesk.Agente.ServiceCore"
$logPath = "C:\ProgramData\Milvus\Scripts\milvus-service-restart.log"

function Log($msg) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $msg
    Add-Content -Path $logPath -Value $line -Encoding UTF8
}

Log "Iniciando reinicio do servico $serviceName"

try {
    Restart-Service -Name $serviceName -Force -ErrorAction Stop
    Log "Servico reiniciado com sucesso"
}
catch {
    Log "Erro ao reiniciar servico: $_"
}