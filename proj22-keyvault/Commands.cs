using Azure.Security.KeyVault.Secrets;

class Commands : ConsoleAppBase
{
    private readonly SecretClient _client;
    public Commands(SecretClient client) =>
        _client = client;

    public void Get(string key)
    {
        KeyVaultSecret s = _client.GetSecret(key);
        Console.WriteLine(s.Value);
    }
}