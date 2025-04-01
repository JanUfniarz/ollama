if ($args[0] -like '/*') {
    switch ($args[0]) {
        /c { '' > context.json }
        /b { docker-compose up }
        default { Write-host "Invalid command: $($args[0])" }
    }
} else {
    if ($args.Length -eq 0) {
        $prompt = Read-Host "Prompt"
        python .\wrapper.py $prompt
    } else {
        python .\wrapper.py $args
    }
    glow output.md
    '' > output.md
}
