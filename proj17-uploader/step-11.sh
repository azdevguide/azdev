### Step 11: ローカルのWebアプリをApp Serviceアプリへデプロイ

# .azure フォルダがあれば削除
if [ -d '.azure' ]; then rm -rf '.azure'; fi

# デプロイされたアプリとプランの名前を取得
app=$(az webapp list -g "$g" --query '[].name' -otsv)
plan=$(az appservice plan list -g "$g" --query '[].name' -otsv)

# ローカルのWebアプリをApp Serviceアプリへデプロイ
az webapp up -n "$app" -g "$g" -p "$plan" -l "$l" \
--os-type 'Windows' --runtime 'dotnet:7' --sku 'F1'

# .azure フォルダが自動的に作成されるが不要なので削除
if [ -d '.azure' ]; then rm -rf '.azure'; fi

# App ServiceのアプリをWebブラウザーで開く
az webapp browse -n "$app" -g "$g"

echo 'App ServiceのアプリをWebブラウザーで開きました。'
echo 'アップローダーの動作を確認してください。'
