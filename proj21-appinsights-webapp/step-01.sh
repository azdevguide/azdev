### Step 1: プロジェクトの作成

dotnet new webapp --force >> logs/dotnet-new.txt

# ユーザーシークレットIDを削除（.csprojの変更を防止）
sed -i '/UserSecretsId/d' *.csproj

# 実行時の「ビルドしています...」の表示を抑止
sed -i '/dotnetRunMessages/ s/true/false/' Properties/launchSettings.json
