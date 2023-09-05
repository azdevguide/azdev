### Step 8: 設定ファイルの作成

q='{blob:{endpoint:join(``,[[0].primaryEndpoints.blob,`images`])}}'
az storage account list -g $g --query "$q" > appsettings.json
