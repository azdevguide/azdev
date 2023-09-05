#!/bin/bash

set -x
export MSYS_NO_PATHCONV=1

# 開発者グループ`developers`の作成

echo 'Webブラウザーが開き、Azureのサインイン画面が表示されます。サインインしてください。'
sleep 3
az login --scope https://graph.microsoft.com//.default

developersId=$(az ad group create \
    --display-name 'developers' \
    --mail-nickname 'developers' \
    --query id -otsv |tr -d '\r\n')

# サインインしているユーザーのオブジェクトIDを取得

#userName=$(az account show --query 'user.name' -otsv|tr -d '\r\n')
#userId=$(az ad user show --id $userName --query id -otsv|tr -d '\r\n')
userId=$(az ad signed-in-user show --query id -otsv|tr -d '\r\n')

# ユーザーを`developers`グループに入れる
az ad group member add --group 'developers' --member-id "$userId"

# サブスクリプションIDを取得
subscriptionId=$(az account show --query id -otsv |tr -d '\r\n')

# サブスクリプションのスコープで`developers`に`Key Vault Secrets Officer`を割り当てる

az role assignment create \
--role 'Key Vault Secrets Officer' \
--scope "/subscriptions/$subscriptionId" \
--assignee-object-id "$developersId" \
--assignee-principal-type 'Group'

# サブスクリプションのスコープで`developers`に`App Configuration Data Owner`を割り当てる

az role assignment create \
--role 'App Configuration Data Owner' \
--scope "/subscriptions/$subscriptionId" \
--assignee-object-id "$developersId" \
--assignee-principal-type 'Group'

# サブスクリプションのスコープで`developers`に`Storage Blob Data Contributor`を割り当てる

az role assignment create \
--role 'Storage Blob Data Contributor' \
--scope "/subscriptions/$subscriptionId" \
--assignee-object-id "$developersId" \
--assignee-principal-type 'Group'

