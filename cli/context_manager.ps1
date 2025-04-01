function copy-context {
    Get-Content ..\data\context.json > "..\data\previous_conversations\$(topic).json"
}

function topic {
    return (Get-Content ..\data\topic.txt -Raw).Trim() -replace "\s", "_"
}

function save-context {
    param($new_topic)

    if ($new_topic) {
        $new_topic > ..\data\topic.txt
        save-context
    } elseif (-not $(topic) -or ($(topic) -match '^\s*$')) {
        Write-Host 'Provide topic!' -Foreground 'red'
    } else {
        save-context
    }
}

function load-context {
    $conv = Get-ChildItem -Path ..\data\previous_conversations `
                    | Select-Object -ExpandProperty Name `
                    | fzf

    $conv = $conv -replace "^\s+|\uFEFF", ""

    Get-Content "..\data\previous_conversations\$conv" > ..\data\context.json
    $conv = $conv -replace ".json", ""
    $conv > ..\data\topic.txt
    Write-Host "Context loaded!\nTopic: $conv" -Foreground 'green'
}