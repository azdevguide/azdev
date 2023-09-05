### Step 10: リソースグループの削除

# Cognitive Servicesアカウント名を取得
accountname=$(az cognitiveservices account list -g $g --query '[].name' -o tsv|tr -d '\r\n')
# リソースグループを削除
az group delete -n $g -y
# 削除されたCognitive Servicesアカウントが「削除されたリソース」となって48時間残る。それも削除(purge)する。
sleep 5
az cognitiveservices account purge -l $l -n "$accountname" -g $g
