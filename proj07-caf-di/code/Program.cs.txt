using MailService;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
    services.AddSingleton<IMailSender, MailSender>())
.Build().AddCommands<Commands>().Run();