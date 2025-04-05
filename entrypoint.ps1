function ai {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$arguments
    )

    $data_path = '..\..\data'

    $originalPath = $PWD.Path

    try {
        Set-Location "$PSScriptRoot\cli"

        if ($arguments[0] -like '/*') {
            . .\manage.ps1 @arguments
        } else {
            if ($arguments.Length -eq 0) {
                $prompt = Read-Host "Prompt"
                python ..\wrapper\wrapper.py $prompt
            } else {
                python ..\wrapper\wrapper.py @arguments
            }
            glow $data_path\output.md
            '' > $data_path\output.md
        }
    } finally {
        Set-Location $originalPath
    }
}