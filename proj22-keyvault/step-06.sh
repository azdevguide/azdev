### Step 6: 設定ファイル`appsettings.json`の作成
q='{keyvault:{endpoint:[0].properties.vaultUri}}'
az keyvault list -g $g --query "$q" > appsettings.json
