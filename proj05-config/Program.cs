using Microsoft.Extensions.Configuration;
// (1)ビルダーに構成プロバイダーを追加
var builder = new ConfigurationBuilder();
builder.AddJsonFile("appsettings.json");
// (2)構成をビルド
var config = builder.Build();
// (3)構成から設定を取得
var x = config["x"];
Console.WriteLine(x);