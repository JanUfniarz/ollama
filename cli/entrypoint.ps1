if ($args[0] -like '/*') {
    . .\manage.ps1 @args
} else {
    if ($args.Length -eq 0) {
        $prompt = Read-Host "Prompt"
        python ..\wrapper\wrapper.py $prompt
    } else {
        python ..\wrapper\wrapper.py @args
    }
    glow ..\..\data\output.md
    '' > ..\..\data\output.md
}
