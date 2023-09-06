### Step 10: Key Vaultへのシークレットの設定

# Key Vaultのリソース名を取得
kvName=$(az keyvault list -g $g --query "[0].name" -otsv |tr -d '\r\n')

# シークレットを設定（azコマンドから）
az keyvault secret set \
--vault-name $kvName -n secret1 --value secretvalue1

# シークレットを取得（azコマンドから）
az keyvault secret show \
--vault-name $kvName -n secret1 --query value -otsv
