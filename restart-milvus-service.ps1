$serviceName = "Milvus.Helpdesk.Agente.ServiceCore"
$logPath = "C:\ProgramData\Milvus\Scripts\milvus-service-restart.log"

function Log($msg) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $msg
    Add-Content -Path $logPath -Value $line -Encoding UTF8
}

$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($null -eq $service) {
    Log "Servico nao encontrado: $serviceName"
    exit
}

Log "Status atual: $($service.Status)"

try {

    if ($service.Status -eq "Running") {

        Log "Servico em execucao. Reiniciando..."
        Restart-Service -Name $serviceName -Force -ErrorAction Stop
        Log "Servico reiniciado com sucesso"

    }
    else {

        Log "Servico parado. Iniciando..."
        Start-Service -Name $serviceName -ErrorAction Stop
        Log "Servico iniciado com sucesso"

    }

}
catch {
    Log "Erro ao manipular servico: $_"
}