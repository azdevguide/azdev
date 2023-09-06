// 追加ここから
using Microsoft.ApplicationInsights.Extensibility;
using Azure.Identity;
// 追加ここまで

var builder = WebApplication.CreateBuilder(args);

// 追加ここから
builder.Services.AddApplicationInsightsTelemetry();
builder.Logging.AddApplicationInsights();
builder.Services.Configure<TelemetryConfiguration>(config =>
    config.SetAzureTokenCredential(new DefaultAzureCredential())
);
// 追加ここまで

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
