/* 追加ここから */
using MailService;
/* 追加ここまで */

var builder = WebApplication.CreateBuilder(args);

/* 追加ここから */
// DIのコード
IServiceCollection serviceCollection = builder.Services;
serviceCollection.AddSingleton<IMailSender, MailSender>();

// ロギングのコード
ILoggingBuilder loggingBuilder = builder.Logging;
loggingBuilder.ClearProviders();
loggingBuilder.AddSimpleConsole(options =>
{
  options.SingleLine = true;
});

// 構成のコード
IConfigurationBuilder confBuilder = builder.Configuration;
confBuilder.AddEnvironmentVariables("MYCONFIG_");
/* 追加ここまで */

// Add services to the container.
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();
