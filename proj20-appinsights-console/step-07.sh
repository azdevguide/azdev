### Step 7: アプリの実行（イベントとログの送信）
tests=10
for i in `seq 1 $tests`; do
    echo ==============================================
    echo "Application Insights 動作テスト ($i / $tests)"
    date
    echo Azure portalのApplication Insightsで
    echo 「トランザクションの検索」を更新してください
    echo （Azure portalに表示されるまで時間がかかります）
    echo ==============================================
    echo カスタムイベントの送信のテスト
    dotnet run test-event
    echo ログの送信のテスト（テストの例外が表示されます）
    dotnet run test-logging
    if [ "$i" != "$tests" ]; then
        echo '1分待ちます'
        sleep 60
    fi
done
