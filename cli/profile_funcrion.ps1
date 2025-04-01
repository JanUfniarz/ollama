function ai {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$arguments
    )

    $originalPath = $PWD.Path

    Set-Location ~\Projects\my_tools\ollama\cli
    if ($arguments.Length -eq 0) {
        . .\entrypoint.ps1
    } else {
        . .\entrypoint.ps1 @arguments
    }

    Set-Location $originalPath
}