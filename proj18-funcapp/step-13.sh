### Step 13: 関数の発行

# 関数名
app=$(az functionapp list -g $g --query '[].name' -otsv|tr -d '\r\n')

# 発行
func azure functionapp publish $app

# 関数が安定するまで少し待つ
sleep 60
