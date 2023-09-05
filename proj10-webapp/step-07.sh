### Step 7: 動作確認

# アプリを実行
export MYCONFIG_MESSAGE='Hello from environment variable'
dotnet run --urls=http://localhost:8080 &

# しばらく待ちます。
# この間に http://localhost:8080/Sample に
# Webブラウザーでアクセスして動作を確認することができます。

sleep 20

# サンプルページへのアクセス
curl -s http://localhost:8080/Sample -o logs/page.txt

sleep 3

# バックグラウンドで起動したWebアプリのジョブのkill
kill %1
