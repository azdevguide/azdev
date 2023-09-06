### Step 12: 再実行(3回目, 1.0.1)、ログ取得
sleep 10
az container start -n date -g $g
az container logs -n date -g $g
