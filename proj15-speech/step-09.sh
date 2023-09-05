### Step 9: リソースグループの削除
az group delete -n $g -y

# Cognitive Serviceアカウントを削除すると「削除されたリソース」となって48時間残るので、こちらも削除する
# subscriptionId=$(az account show --query id -o tsv|tr -d '\r\n')
# az rest --method get --header 'Accept=application/json' -u "https://management.azure.com/subscriptions/$subscriptionId/providers/Microsoft.CognitiveServices/deletedAccounts?api-version=2021-04-30" --query 'value[].id' -o tsv|while read -r id; do
#     id=$(echo $id|tr -d '\r\n')
#     az rest --method delete --header 'Accept=application/json' -u "https://management.azure.com$id?api-version=2021-04-30"
# done

# 以下参考 Cognitive Service アカウント リソースをpurge
# https://learn.microsoft.com/ja-jp/azure/cognitive-services/manage-resources
