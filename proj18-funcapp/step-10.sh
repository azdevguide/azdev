### Step 10: 開発環境での関数のテスト

# 関数を起動（ジョブとして）
func start > logs/func.txt &

# 関数が起動するのを待つ
until grep -q 'Worker process started' logs/func.txt; do sleep 1; done
