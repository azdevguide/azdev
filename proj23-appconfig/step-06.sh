### Step 6: 設定ファイルの作成
q='{appconfig:{endpoint:[0].endpoint}}'
az appconfig list -g $g --query "$q" > appsettings.json
