$command = $args[0]
$management_args = $args | Select-Object -Skip 1

switch ($args[0]) {
    /c {
        '' > ..\data\context.json
        Write-Host 'Context cleaned!' -Foreground 'green'
    }

    /u { docker-compose up }

    /d { docker-compose down }

    /h { glow .\help_info.md }

    /o { docker exec ollama ollama $management_args }

    /m {
        $management_args > ..\data\model.txt
        Write-Host 'Model changed!' -Foreground 'green'
    }

    default {
        Write-host "Invalid command: $($args[0])" -Foreground 'red'
    }
}