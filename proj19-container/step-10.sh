### Step 10: ACIでコンテナーを実行(2回目, 1.0.1)
az container create -n date -g $g --restart-policy Never \
--image $acr.azurecr.io/date:1.0.1 \
--acr-identity $id --assign-identity $id
