### Step 7: Key Vaultにアクセスできるようになるまで待つ

endpoint=$(az keyvault list -g $g --query '[].properties.vaultUri' -otsv |tr -d '\r\n')
proj99-azdev-tool wait-key-vault --endpoint "$endpoint"
