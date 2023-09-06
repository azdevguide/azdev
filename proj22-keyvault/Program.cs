using Azure.Identity;
using Azure.Security.KeyVault.Secrets;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
{
    var credential = new DefaultAzureCredential();
    var endpoint = context.Configuration["keyvault:endpoint"] ?? "";
    var uri = new Uri(endpoint);
    var client = new SecretClient(uri, credential);
    services.AddSingleton(client);
})
.Build().AddCommands<Commands>().Run();