using Microsoft.Extensions.DependencyInjection;
using MailService;

var serviceCollection = new ServiceCollection();
serviceCollection.AddSingleton<IMailSender, MailSender>();
serviceCollection.AddSingleton<Commands>();
var serviceProvider = serviceCollection.BuildServiceProvider();
var commands = serviceProvider.GetRequiredService<Commands>();
commands.SendTestMail();
