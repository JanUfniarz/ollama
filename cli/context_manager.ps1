$data_path = '..\..\data'

function copy-context {
    Get-Content $data_path\active_conversation\context.json > "$data_path\previous_contexts\$(topic).json"
    Get-Content $data_path\active_conversation\show_conversation.md > "$data_path\previous_conversations\$(topic).md"
}

function topic {
    return (Get-Content $data_path\active_conversation\topic.txt -Raw).Trim() -replace "\s", "_"
}

function save-context {
    param($new_topic)

    if ($new_topic) {
        $new_topic > $data_path\active_conversation\topic.txt
    } elseif (-not $(topic) -or ($(topic) -match '^\s*$')) {
        $topic = Read-Host "Topic"
        $topic > $data_path\active_conversation\topic.txt
    }
    copy-context
    Write-Host "Context saved!" -Foreground 'green'
}

function load-context {
    $conv = Get-ChildItem -Path $data_path\previous_contexts `
                    | Select-Object -ExpandProperty Name `
                    | fzf

    $conv = $conv -replace "^\s+|\uFEFF", ""

    Get-Content "$data_path\previous_contexts\$conv" > $data_path\active_conversation\context.json

    $conv = $conv -replace ".json", ""
    Get-Content "$data_path\previous_conversations\$conv.md" > $data_path\active_conversation\show_conversation.md

    $conv > $data_path\active_conversation\topic.txt
    Write-Host "Context loaded!" -Foreground 'green'
    Write-Host "Topic: $conv"
}