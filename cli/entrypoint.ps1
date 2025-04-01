if ($args[0] -like '/*') {
    switch ($args[0]) {
        /c { '' > ..\data\context.json }
        /b { docker-compose up }
        default { Write-host "Invalid command: $($args[0])" }
    }
} else {
    if ($args.Length -eq 0) {
        $prompt = Read-Host "Prompt"
        python ..\wrapper\wrapper.py $prompt
    } else {
        python ..\wrapper\wrapper.py @args
    }
    glow ..\data\output.md
    '' > ..\data\output.md
}
