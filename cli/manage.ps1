switch ($args[0]) {
    /c {
        '' > ..\data\context.json
        Write-Host 'Context cleaned!' -Foreground 'green'
    }

    /u { docker-compose up }

    /d { docker-compose down }

    /h { glow .\help_info.md }

    /m {
        $model_args = $args | Select-Object -Skip 1
        docker exec ollama ollama $model_args
    }

    default { Write-host "Invalid command: $($args[0])" }
}

