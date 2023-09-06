### Step 14: Azureでの関数のテスト

until
    # テスト用画像`dog.jpg`をストレージアカウント内のinputコンテナーにアップロード
    proj99-azdev-tool upload-blob \
        --endpoint "$endpoint" --container 'input' --path 'dog.jpg'

    # Azure Functionsで関数が実行されるまで少し待つ
    sleep 30

    # 生成された画像`dog.png`をダウンロード
    EXIT_CODE=0
    proj99-azdev-tool download-blob \
        --endpoint "$endpoint" --container 'output' \
        --path 'dog.png' >> logs/blob.txt || EXIT_CODE=$?

    # 成功?
    [ "$EXIT_CODE" = "0" ]
do
    # 関数が動作するまでリトライ
    sleep 10
done

# ダウンロードした`dog.png`を確認(100x100のサイズになっている)
file dog.png
