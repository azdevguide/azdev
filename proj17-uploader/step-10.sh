### Step 10: ローカルでの動作確認

# バックグランドでWebアプリを実行
dotnet run --urls=http://localhost:8080 &

sleep 10

echo 'Webブラウザーで http://localhost:8080 にアクセスして、'
echo 'アップローダーの動作を確認してください。'
read -p '確認が終わったらEnterキーを押してください: '

kill %1
