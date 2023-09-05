class Commands : ConsoleAppBase
{
    private readonly ILogger<Commands> _logger;
    public Commands(ILogger<Commands> logger) =>
        _logger = logger;
    public void LogSample()
    {
        _logger.LogTrace("trace");
        _logger.LogDebug("debug");
        _logger.LogInformation("information");
        _logger.LogWarning("warning");
        _logger.LogError("error");
        _logger.LogCritical("critical");
    }
}
