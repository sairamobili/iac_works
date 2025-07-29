# PowerShell script to generate Terraform docs for all modules
$moduleDirs = Get-ChildItem -Directory
foreach ($dir in $moduleDirs) {
    Write-Host "Processing $($dir.FullName)"
    Set-Location $dir.FullName
    if (-not (Test-Path "README.md")) {
        "# Module: $($dir.Name)`n`n<!-- BEGIN_TF_DOCS -->`n<!-- END_TF_DOCS -->" | Out-File -Encoding utf8 "README.md"
    } elseif (-not (Select-String -Path "README.md" -Pattern "BEGIN_TF_DOCS")) {
        Add-Content -Path "README.md" "`n<!-- BEGIN_TF_DOCS -->`n<!-- END_TF_DOCS -->"
    }
    terraform-docs markdown table --output-file README.md --output-mode inject .
    Set-Location ..
}
Write-Host "Documentation updated for all modules."
