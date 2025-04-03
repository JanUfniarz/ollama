$data_path = '..\..\data'

function copy-context {
    Get-Content $data_path\active_conversation\context.json > "$data_path\previous_contexts\$(topic).json"
    Get-Content $data_path\active_conversation\show_conversation.md > "$data_path\previous_conversations\$(topic).md"
}

function topic {
    $res = Get-Content $data_path\active_conversation\topic.txt -Raw
    if ($res) { $res = $res.Trim() -replace "\s", "_" }
    return $res
}

function select-topic {
    $res = Get-ChildItem -Path $data_path\previous_contexts `
                    | Select-Object -ExpandProperty Name `
                    | ForEach-Object { $_ -replace ".json", "" } `
                    | fzf
    return $res -replace "^\s+|\uFEFF", ""
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
    $conv = select-topic

    Get-Content "$data_path\previous_contexts\$conv.json" > $data_path\active_conversation\context.json
    Get-Content "$data_path\previous_conversations\$conv.md" > $data_path\active_conversation\show_conversation.md

    $conv > $data_path\active_conversation\topic.txt
    Write-Host "Context loaded!" -Foreground 'green'
    Write-Host "Topic: $conv"
}

function remove-context {
    $conv = select-topic
    Remove-Item "$data_path\previous_contexts\$conv.json"
    Remove-Item "$data_path\previous_conversations\$conv.md"
}