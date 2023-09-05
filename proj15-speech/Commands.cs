using Microsoft.CognitiveServices.Speech;

class Commands : ConsoleAppBase
{
    private readonly SpeechSynthesizer _synthesizer;
    public Commands(SpeechSynthesizer synthesizer) =>
        _synthesizer = synthesizer;

    public async Task Speech(string message)
    {
        await _synthesizer.SpeakTextAsync(message);
    }
}