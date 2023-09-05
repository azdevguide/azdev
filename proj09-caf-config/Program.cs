ConsoleApp.CreateBuilder(args)
.ConfigureAppConfiguration((context, config) =>
{
    // 構成プロバイダーの追加などを行う
})
.Build().AddCommands<Commands>().Run();
