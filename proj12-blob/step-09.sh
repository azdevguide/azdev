### Step 9: 動作確認(1)Blobのアップロード

# テスト用ファイルを作成
echo hello > test.txt

# Blobをアップロード
dotnet run upload --path test.txt

# Blob一覧で、アップロードされたBlobを確認
dotnet run list
