### Step 6: Azureリソースを作成

# リソースグループ名・リージョン名
g=rg-proj19-$(date "+%Y%m%d-%H%M%S")
l=japaneast

# 変数の値を保存
mkdir -p tmp; set |grep -E '^(g|l)=' > tmp/vars

# リソースグループを作成
az group create -n $g -l $l

# デプロイ
az deployment group create -g $g -f main.bicep
