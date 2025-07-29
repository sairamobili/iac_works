@echo off
REM Batch script to generate Terraform docs for all modules
for /d %%d in (*) do (
    echo Processing %%d
    cd %%d
    if not exist README.md (
        echo # Module: %%d > README.md
        echo. >> README.md
        echo <!-- BEGIN_TF_DOCS --> >> README.md
        echo <!-- END_TF_DOCS --> >> README.md
    ) else (
        findstr /C:"BEGIN_TF_DOCS" README.md >nul 2>&1
        if errorlevel 1 (
            echo. >> README.md
            echo <!-- BEGIN_TF_DOCS --> >> README.md
            echo <!-- END_TF_DOCS --> >> README.md
        )
    )
    terraform-docs markdown table --output-file README.md --output-mode inject .
    cd ..
)
echo Documentation updated for all modules.
