using Azure.Core;
using Azure.Identity;
using Microsoft.CognitiveServices.Speech;
using Microsoft.CognitiveServices.Speech.Audio;

namespace SpeechServiceExtensions;

public static class SpeechServiceExtensions
{
    public static void AddSpeechSynthesizer(this IServiceCollection services, IConfigurationSection section)
    {
        var credential = new DefaultAzureCredential();
        var resourceId = section["resourceId"];
        var context = new TokenRequestContext(
            new[] { "https://cognitiveservices.azure.com/.default" });
        var token = credential.GetToken(context).Token;
        var authorizationToken = $"aad#{resourceId}#{token}";

        var speechConfig = SpeechConfig.FromAuthorizationToken(
            authorizationToken, section["region"]);
        speechConfig.SpeechSynthesisLanguage = section["language"];
        speechConfig.SpeechSynthesisVoiceName = section["voiceName"];

        var audioConfig = "speaker" == section["output"] ?
            AudioConfig.FromDefaultSpeakerOutput() :
            AudioConfig.FromWavFileOutput(section["output"]);

        services.AddSingleton(speechConfig);
        services.AddSingleton(audioConfig);
        services.AddSingleton<SpeechSynthesizer>();
    }
}