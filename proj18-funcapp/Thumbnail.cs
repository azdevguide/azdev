using System;
using System.IO;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
// 追加ここから
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Processing;
// 追加ここまで

namespace proj20_funcapp;

public class Thumbnail
{
    // 追加ここから
    private const int THUMB_SIZE = 100;
    // 追加ここまで
    private readonly ILogger _logger;

    public Thumbnail(ILoggerFactory loggerFactory)
    {
        _logger = loggerFactory.CreateLogger<Thumbnail>();
    }
    // 変更ここから
    [Function("Thumbnail")]
    [BlobOutput("output/{name}.png")]
    public byte[] Run(
        [BlobTrigger("input/{name}.{ext}")] byte[] imageBytes,
        string name, string ext)
    {
        _logger.LogInformation(
            "Processing: {name}.{ext}", name, ext);
        using var outputStream = new MemoryStream();
        using var image = Image.Load(imageBytes);
        image.Mutate(context =>
            context.Resize(THUMB_SIZE, THUMB_SIZE));
        image.SaveAsPng(outputStream);
        return outputStream.ToArray();
    }
    // 変更ここまで
}

