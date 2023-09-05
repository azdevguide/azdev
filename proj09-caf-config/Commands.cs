class Commands : ConsoleAppBase
{
    private readonly IConfiguration _config;
    public Commands(IConfiguration config) => _config = config;
    public void ConfigSample() =>
        Console.WriteLine($"message: {_config["message"]}");
}