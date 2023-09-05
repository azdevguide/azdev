### Step 7: Azureリソースのデプロイ

az deployment group create -g $g \
    -f main.bicep -p principalId=$AZDEVSP_OBJECT_ID
