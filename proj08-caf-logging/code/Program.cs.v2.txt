ConsoleApp.CreateBuilder(args, options =>
{
    options.ReplaceToUseSimpleConsoleLogger = false;
})
.Build()
.AddCommands<Commands>().Run();
