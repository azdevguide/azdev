// 追加ここから
using Azure.Storage.Blobs;
using Azure.Identity;
// 追加ここまで

var builder = WebApplication.CreateBuilder(args);

// 追加ここから
var endpoint = builder.Configuration["blob:endpoint"] ?? "";
var uri = new Uri(endpoint);
var credential = new DefaultAzureCredential();
var client = new BlobContainerClient(uri, credential);
builder.Services.AddSingleton(client);
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
