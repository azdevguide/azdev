### Step 8: 実行結果の確認

sleep 10
tests=10
for i in `seq 1 $tests`; do
    echo ==============================================
    echo "Application Insights 動作テスト ($i / $tests)"
    date
    echo Azure portalのApplication Insightsで
    echo 「トランザクションの検索」を更新してください
    echo （Azure portalに表示されるまで時間がかかります）
    echo ==============================================
    echo トップページにアクセスします。
    echo （テストの例外が表示されます）
    curl http://localhost:8080 > /dev/null
    if [ "$i" != "$tests" ]; then
        echo '1分待ちます'
        sleep 60
    fi
done

# ジョブを終了させる
kill %1
