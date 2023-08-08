using Azure.Communication.Email;
using Azure.Identity;
using MailService;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
{
    var hostName = context.Configuration["mail:hostName"];
    var uri = new Uri($"https://{hostName}");
    var credential = new DefaultAzureCredential();
    var client = new EmailClient(uri, credential);
    services.AddSingleton(client);
    services.AddSingleton<IMailSender, MailSender>();
}).Build().AddCommands<Commands>().Run();