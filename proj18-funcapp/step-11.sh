### Step 11: 関数の動作（サムネイル生成）を確認

# テスト用画像`cat.jpg`をストレージアカウント内のinputコンテナーにアップロード
proj99-azdev-tool upload-blob \
    --endpoint "$endpoint" --container 'input' --path 'cat.jpg'

# 関数が実行されるのを待つ
until grep -q 'Executed.*Functions.Thumbnail.*Succeeded' logs/func.txt; do sleep 1; done

# 生成された画像`cat.png`をダウンロード
proj99-azdev-tool download-blob \
    --endpoint "$endpoint" --container 'output' --path 'cat.png'

# ダウンロードした`cat.png`を確認(100x100のサイズになっている)
file cat.png
