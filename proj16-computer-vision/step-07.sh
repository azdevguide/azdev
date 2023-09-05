### Step 7: Azureリソースの作成

# リソースグループ名とリージョン
g=rg-proj16-$(date "+%Y%m%d-%H%M%S")
l=japaneast

# 変数の値を保存
mkdir -p tmp; set |grep -E '^(g|l)=' > tmp/vars

# リソースグループの作成
az group create -n $g -l $l

# Azureリソースのデプロイ
az deployment group create -n $g -g $g \
    -f main.bicep -p principalId=$AZDEVSP_OBJECT_ID
