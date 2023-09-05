using Microsoft.Extensions.Logging;
// (1)ロガーを作るファクトリを作成
using var loggerFactory = LoggerFactory.Create(builder =>
{
    // (2)ログプロバイダーを追加
    builder.AddSimpleConsole(options =>
    {
        options.SingleLine = true;
    });
    // (3)フィルターを追加
    builder.AddFilter(nameof(Program), LogLevel.Trace);
});
// (4)ロガーを取得
var logger = loggerFactory.CreateLogger<Program>();
// (5)ロガーを使用してログを出力
logger.LogTrace("trace");
logger.LogDebug("debug");
logger.LogInformation("information");
logger.LogWarning("warning");
logger.LogError("error");
logger.LogCritical("critical");
//(6)ログをフラッシュ（掃き出し）
Console.Out.Flush();
