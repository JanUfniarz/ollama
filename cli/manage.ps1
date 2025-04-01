switch ($args[0]) {
    /c {
        '' > ..\data\context.json
        Write-Host 'Context cleaned!' -Foreground 'green'
    }
    /u { docker-compose up }
    /d { docker-compose down }
    /h { glow .\help_info.md }
    default { Write-host "Invalid command: $($args[0])" }
}

