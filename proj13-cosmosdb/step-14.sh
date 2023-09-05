### Step 14: 動作確認(5)データの削除

# 顧客とIDを指定して、注文データを削除
dotnet run delete --customer yamada --id 1

# すべての注文データを取得して、削除を確認
dotnet run select-all
