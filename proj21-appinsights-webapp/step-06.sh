### Step 6: 設定ファイルの作成
q='{ApplicationInsights:{ConnectionString:properties.outputs.connectionString.value}}'
az deployment group show -n $g -g $g --query "$q" > appsettings.json
