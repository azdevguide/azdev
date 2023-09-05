using Microsoft.Azure.CognitiveServices.Vision.ComputerVision;

class Commands : ConsoleAppBase
{
    private readonly ComputerVisionClient _client;
    public Commands(ComputerVisionClient client) =>
        _client = client;
    public async Task DescribeImage(string url)
    {
        var description = await _client.DescribeImageAsync(url, 3, "ja");
        description.Captions.ToList().ForEach(caption =>
            Console.WriteLine($"{caption.Text} {caption.Confidence}"));
    }
}