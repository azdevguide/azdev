using ComputerVisionExtensions;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
{
    var endpoint = context.Configuration["cv:endpoint"] ?? "";
    services.AddComputerVisionClient(endpoint);
})
.Build().AddCommands<Commands>().Run();