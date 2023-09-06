### Step 8: Key Vaultへのシークレットの設定

# Key Vaultのリソース名を取得
name=$(az keyvault list -g $g --query "[0].name" -otsv|tr -d '\r\n')

# シークレットを設定（azコマンドから）
az keyvault secret set \
--vault-name $name -n key1 --value value1

# シークレットを取得（azコマンドから）
az keyvault secret show \
--vault-name $name -n key1 --query value -otsv
