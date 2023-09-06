### Step 5: テスト用の画像を準備

# テスト用画像`cat.jpg`の入手
curl -L -s -o cat.jpg https://github.com/azdevguide/azdev/raw/main/proj18-funcapp/cat.jpg

# テスト用画像`dog.jpg`の入手
curl -L -s -o dog.jpg https://github.com/azdevguide/azdev/raw/main/proj18-funcapp/dog.jpg

# ローカルの`cat.png`ファイルがある場合は削除
if [ -f cat.png ]; then rm cat.png; fi

# ローカルの`dog.png`ファイルがある場合は削除
if [ -f dog.png ]; then rm dog.png; fi
