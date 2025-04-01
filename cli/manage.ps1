$command = $args[0]
$management_args = $args | Select-Object -Skip 1

function save-context {
    Get-Content ..\data\context.json > "..\data\previous_conversations\$(topic).json"
}

function topic {
    return (Get-Content ..\data\topic.txt -Raw).Trim() -replace "\s", "_"
}

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
    /s {
        if ($management_args) {
            $management_args > ..\data\topic.txt
            save-context
        } elseif (-not $(topic) -or ($(topic) -match '^\s*$')) {
            Write-Host 'Provide topic!' -Foreground 'red'
        } else {
            save-context
        }
    }

    # load context
    /l {
        $conv = Get-ChildItem -Path ..\data\previous_conversations `
                    | Select-Object -ExpandProperty Name `
                    | fzf

        $conv = $conv -replace "^\s+|\uFEFF", ""

        Get-Content "..\data\previous_conversations\$conv" > ..\data\context.json
        $conv -replace ".json", "" > ..\data\topic.txt
    }

    /t {}

    default {
        Write-host "Invalid command: $($args[0])" -Foreground 'red'
    }
}