### Step 8: 設定ファイルの作成
az deployment group show -n $g -g $g \
    --query "{cv:{endpoint: properties.outputs.endpoint.value}}" > appsettings.json
