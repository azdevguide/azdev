### Step 6: リソースグループの作成

# リソースグループ名とリージョン
g=rg-proj17-$(date "+%Y%m%d-%H%M%S")
l=japaneast

# 変数の値を保存
mkdir -p tmp; set |grep -E '^(g|l)=' > tmp/vars

# リソースグループの作成
az group create -n $g -l $l
