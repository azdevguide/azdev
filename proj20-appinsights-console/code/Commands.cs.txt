using Microsoft.ApplicationInsights;

class Commands : ConsoleAppBase, IAsyncDisposable
{
    private readonly TelemetryClient _tc;
    private readonly ILogger<Commands> _logger;
    public Commands(TelemetryClient tc, ILogger<Commands> logger) =>
      (_tc, _logger) = (tc, logger);


    // トランザクションの CUSTOM EVENT として記録される
    public void TestEvent() =>
        _tc.TrackEvent("コマンドの呼び出し",
            new Dictionary<string, string>
            {
                { "commandName", nameof(TestEvent) }
            });

    public void TestLogging()
    {
        try
        {
            throw new NullReferenceException("これはテストです");
        }
        catch (Exception e)
        {
            _logger.LogError(e, 
                "コマンド {} の実行中にエラーが発生しました",
                nameof(TestLogging));
        }
    }
    public async ValueTask DisposeAsync() =>
        await _tc.FlushAsync(default);

}