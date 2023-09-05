using Azure.Storage.Blobs;
using Azure.Identity;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
{
    var endpoint = context.Configuration["blob:endpoint"] ?? "";
    var uri = new Uri(endpoint);
    var credential = new DefaultAzureCredential();
    var client = new BlobContainerClient(uri, credential);
    services.AddSingleton(client);
})
.Build().AddCommands<Commands>().Run();