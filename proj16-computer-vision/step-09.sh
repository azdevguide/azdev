### Step 9: 動作確認
# ※URLには、インターネットでアクセスが可能な画像のURLを指定
dotnet run describe-image --url 'https://github.com/azdevguide/azdev/raw/main/proj16-computer-vision/test.jpg'

# (実行結果例):
# 屋外に立っている猫 0.565643330965331
# 屋外にいる猫 0.564643330965331
# 台の上に座っている猫 0.5008907090332411
