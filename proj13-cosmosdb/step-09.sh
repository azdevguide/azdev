### Step 9: Cosmos DBにアクセスできるようになるまで待つ

endpoint=$(az cosmosdb list -g $g --query '[].documentEndpoint' -otsv|tr -d '\r\n')
proj99-azdev-tool wait-cosmos --endpoint "$endpoint"
