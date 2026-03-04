$serviceName = "Milvus.Helpdesk.Agente.ServiceCore"

$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($null -eq $service) {
    Write-Output "Servico nao encontrado: $serviceName"
    exit
}

Write-Output "Reiniciando servico: $serviceName"

try {
    Restart-Service -Name $serviceName -Force -ErrorAction Stop
    Write-Output "Servico reiniciado com sucesso."
}
catch {
    Write-Output "Erro ao reiniciar o servico: $_"
}