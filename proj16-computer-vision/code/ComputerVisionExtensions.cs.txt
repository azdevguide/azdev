using Azure.Core;
using Azure.Identity;
using Microsoft.Azure.CognitiveServices.Vision.ComputerVision;
using Microsoft.Rest;

namespace ComputerVisionExtensions;

public static class ComputerVisionExtensions
{
    public static void AddComputerVisionClient(
        this IServiceCollection services, string endpoint)
    {
        var cred = new DefaultAzureCredential();
        var context = new TokenRequestContext(
            new[] { "https://cognitiveservices.azure.com/.default" });
        var token = cred.GetToken(context);
        var tokenCredential = new TokenCredentials(token.Token);
        var client = new ComputerVisionClient(tokenCredential)
            { Endpoint = endpoint };
        services.AddSingleton(client);
    }
}