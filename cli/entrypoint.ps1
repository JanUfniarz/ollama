$data_path = '..\..\data'

if ($args[0] -like '/*') {
    . .\manage.ps1 @args
} else {
    if ($args.Length -eq 0) {
        $prompt = Read-Host "Prompt"
        python ..\wrapper\wrapper.py $prompt
    } else {
        python ..\wrapper\wrapper.py @args
    }
    glow $data_path\output.md
    '' > $data_path\output.md
}
