using SpeechServiceExtensions;

ConsoleApp.CreateBuilder(args)
.ConfigureServices((context, services) =>
{
    var speechSection = context.Configuration.GetSection("speech");
    services.AddSpeechSynthesizer(speechSection);
})
.Build().AddCommands<Commands>().Run();