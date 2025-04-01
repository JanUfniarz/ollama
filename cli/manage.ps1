. ./context_manager.ps1

$command = $args[0]
$management_args = $args | Select-Object -Skip 1

switch ($args[0]) {
    # clear context
    /c {
        '' > ..\data\context.json
        '' > ..\data\topic.txt
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
        $management_args > ..\data\model.txt
        Write-Host 'Model changed!' -Foreground 'green'
    }

    # save context
    /s { save-context $management_args }

    # load context
    /l { load-context }

    # show history ! Not working!!!
    /t {
        python ..\wrapper\detokenizer.py
        glow ..\data\history\
    }

    # info
    /i {
        Write-Host "Model: $(Get-Content ..\data\model.txt -Raw)\nTopic: $(topic)"
    }

    default {
        Write-host "Invalid command: $($args[0])" -Foreground 'red'
    }
}