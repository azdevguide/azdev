using Microsoft.ApplicationInsights.Extensibility;
using Azure.Identity;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
{
    services.Configure<TelemetryConfiguration>(config =>
    {
        var cred = new DefaultAzureCredential();
        config.SetAzureTokenCredential(new DefaultAzureCredential());
    });
    services.AddApplicationInsightsTelemetryWorkerService();
})
.ConfigureLogging((context, logger) =>
{
    logger.AddApplicationInsights();
})
.Build().AddCommands<Commands>().Run();
