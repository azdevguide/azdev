### Step 6: Azureリソースをデプロイ

az deployment group create -n $g -g $g \
-f main.bicep -p principalId=$AZDEVSP_OBJECT_ID
