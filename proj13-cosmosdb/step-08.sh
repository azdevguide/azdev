### Step 8: 設定ファイルの作成
query='{cosmosdb:{endpoint:properties.outputs.endpoint.value}}'
az deployment group show -n $g -g $g \
    --query "$query" > appsettings.json
