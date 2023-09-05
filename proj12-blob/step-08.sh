### Step 8: Blobにアクセスできるようになるまで待つ

endpoint=$(az storage account list -g $g --query '[].primaryEndpoints.blob' -otsv|tr -d '\r\n')
proj99-azdev-tool wait-blob --endpoint "$endpoint"
