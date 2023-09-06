### Step 9: App Configurationへの構成値/機能フラグの設定

# App Configurationのリソース名を取得
appCfgName=$(az appconfig list -g $g --query "[0].name" -otsv |tr -d '\r\n')

# 構成の設定
az appconfig kv set -n $appCfgName --key 'key1' --value 'value1' -y

# 機能フラグの設定
az appconfig feature set -n $appCfgName --feature Feature1 -y
az appconfig feature enable -n $appCfgName --feature Feature1 -y
