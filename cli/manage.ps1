. ./context_manager.ps1
$data_path = '..\..\data'

$command = $args[0]
$management_args = $args | Select-Object -Skip 1

switch ($args[0]) {
    # clear context
    /c {
        Get-ChildItem $data_path\active_conversation\ `
                      | ForEach-Object { "" > $_.FullName }
        Write-Host 'Context cleaned!' -Foreground 'green'
    }

    # container up
    /u { docker-compose up -d }

    # container down
    /d { docker-compose down }

    # show help
    /h { glow .\help_info.md }

    # manage ollama
    /o { docker exec ollama ollama $management_args }

    # change model
    /m {
        $management_args > $data_path\model.txt
        Write-Host 'Model changed!' -Foreground 'green'
    }

    # save context
    /s { save-context $management_args }

    # load context
    /l { load-context }

    # show history
    /t { glow $data_path\active_conversation }

    # info
    /i {
        Write-Host "Model: $(Get-Content $data_path\model.txt -Raw)"
        Write-Host "Topic: $(topic)"
    }

    default {
        Write-host "Invalid command: $($args[0])" -Foreground 'red'
    }
}