### Step 7: コンテナーのビルドと実行(最初のバージョン)

# ACRでイメージをビルド
acr=$(az acr list -g $g --query '[].name' -otsv|tr -d '\r\n')
az acr build -r $acr -t date:1.0.0 .

# ACIでコンテナーを実行
id=$(az identity list -g $g --query '[].id' -otsv|tr -d '\r\n')
az container create -n date -g $g --restart-policy Never \
--image $acr.azurecr.io/date:1.0.0 \
--acr-identity $id --assign-identity $id

# ACIのログを取得
az container logs -n date -g $g
