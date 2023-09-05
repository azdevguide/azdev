### Step 10: 動作確認(1)データを追加

dotnet run insert --customer yamada --id 1 \
    --order-detail '{"beer": 1, "yakitori": 2}'
dotnet run insert --customer yamada --id 2 \
    --order-detail '{"kakuhai": 1}'
dotnet run insert --customer fujii --id 1 \
    --order-detail '{"lemonsour": 1, "potesara": 1}'
dotnet run insert --customer fujii --id 2 \
    --order-detail '{"wine": 1}'
