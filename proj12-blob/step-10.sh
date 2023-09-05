### Step 10: 動作確認(2)Blobのダウンロード

# ローカルのファイルを削除
rm test.txt

# ダウンロード
dotnet run download --path test.txt

# test.txt が存在することを確認
ls *.txt
