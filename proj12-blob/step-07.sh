### Step 7: 設定ファイル`appsettings.json`の作成

az deployment group show -n $g -g $g \
--query '{blob:{endpoint:properties.outputs.endpoint.value}}' \
> appsettings.json
