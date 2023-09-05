### Step 12: 動作確認(3)データの更新

# 注文データの更新
dotnet run update --customer yamada --id 1 \
--order-detail '{"beer": 2, "yakitori": 4}'

# 更新した注文データを取得して確認
dotnet run read --customer yamada --id 1
