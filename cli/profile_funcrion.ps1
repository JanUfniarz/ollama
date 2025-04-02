function ai {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$arguments
    )

    $originalPath = $PWD.Path

    try {
        Set-Location "<path to ollama cli>"
        if ($arguments.Length -eq 0) {
            . .\entrypoint.ps1
        } else {
            . .\entrypoint.ps1 @arguments
        }
    } finally {
        Set-Location $originalPath
    }
}