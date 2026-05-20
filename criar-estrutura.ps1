$base = "D:\Projetos\TH-Launcher\src\modules"
$modulos = @("Clientes", "Produtos", "Vendas")

$camadas = @{
    "Domain"         = @("Entities", "Interfaces", "ValueObjects", "Events")
    "Application"    = @("Commands", "Queries", "Handlers", "Responses", "Extensions")
    "Infrastructure" = @("Repositories", "Extensions", "Scripts")
    "API"            = @("Controllers", "Extensions")
}

foreach ($modulo in $modulos) {
    foreach ($camada in $camadas.Keys) {
        $projeto = "THLauncher.$modulo.$camada"

        # Remove pastas antigas desnecessarias
        $pastasAntigas = @("Controllers", "Dtos", "Entities", "Interfaces", "Services", "Commands", "Queries", "Handlers", "Responses", "Extensions", "Repositories", "Scripts", "ValueObjects", "Events")
        foreach ($pasta in $pastasAntigas) {
            $caminho = "$base\$projeto\$pasta"
            if (Test-Path $caminho) {
                Remove-Item $caminho -Recurse -Force
            }
        }

        # Cria as pastas corretas para a camada
        foreach ($pasta in $camadas[$camada]) {
            $caminho = "$base\$projeto\$pasta"
            New-Item -ItemType Directory -Path $caminho -Force | Out-Null
        }

        Write-Host "OK: $projeto" -ForegroundColor Green
    }
}

Write-Host "`nEstrutura criada com sucesso!" -ForegroundColor Cyan
