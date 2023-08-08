### Step 8: 設定ファイル`appsettings.json`の作成
az deployment group show -n $g -g $g \
    --query '{mail:{user:properties.outputs.doNotReply.value,
        domain:properties.outputs.mailFromSenderDomain.value,
        hostName:properties.outputs.hostName.value}}' > appsettings.json
