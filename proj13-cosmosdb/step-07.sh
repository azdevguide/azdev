### Step 7: Azureリソースのデプロイ
az deployment group create -n $g -g $g \
    -f main.bicep -p principalId=$AZDEVSP_OBJECT_ID
