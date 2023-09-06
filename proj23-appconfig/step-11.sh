### Step 11: Key Vault参照の作成
secretUri="https://$kvName.vault.azure.net/secrets/secret1"
az appconfig kv set-keyvault \
-n $appCfgName --key secret1 \
--secret-identifier "$secretUri" -y
