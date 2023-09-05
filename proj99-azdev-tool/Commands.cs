using Azure;
using Azure.Data.AppConfiguration;
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using Azure.Storage.Blobs;
using Microsoft.Azure.Cosmos;
class Commands : ConsoleAppBase
{
    private readonly DefaultAzureCredential _credential = new();

    private const int MIN_SUCCESS = 3;

    private async Task WaitUntilSuccessAsync(Action action)
    {
        var success = 0;
        while (success < MIN_SUCCESS)
        {
            await Task.Delay(1000, Context.CancellationToken);
            Console.Write($"{DateTime.Now} ");
            try
            {
                action();
                Console.WriteLine("OK");
                success++;
            }
            catch (RequestFailedException e)
            {
                Console.WriteLine($"NG");
                HandleException(e);
            }
        }
    }

    private async Task WaitUntilSuccessAsync(Func<Task> action)
    {
        var success = 0;
        while (success < MIN_SUCCESS)
        {
            await Task.Delay(1000, Context.CancellationToken);
            Console.Write(DateTime.Now);
            try
            {
                await action();
                Console.WriteLine("OK");
                success++;
            }
            catch (RequestFailedException e)
            {
                Console.WriteLine("NG");
                HandleException(e);
            }
            catch (CosmosException e)
            {
                Console.WriteLine("NG");
                HandleException(e);
            }
        }
    }

    private void HandleException(Exception e)
    {
        // Console.WriteLine($"Error Code: {e.ErrorCode}"); // AuthorizationPermissionMismatch
        // Console.WriteLine($"HTTP Status Code: {e.Status}"); // 403
        // Console.WriteLine($"Source: {e.Source}");            // Azure.Storage.Blobs
        // Console.WriteLine($"HTTP Status Code: {e.Message}"); // "This request is not authorized to perform this operation using this permission.\nRequestId:7bf6d7b9-901e-0036-1267-479b4c000000\nTime:2023-02-23T09:15:35.7547136Z\r\nStatus: 403 (This request is not authorized to perform this operation using this permission.)\r\nErrorCode: AuthorizationPermissionMismatch\r\n\r\nContent:\r\n﻿<?xml version=\"1.0\" encoding=\"utf-8\"?><Error><Code>AuthorizationPermissionMismatch</Code><Message>This request is not authorized to perform this operation using this permission.\nRequestId:7bf6d7b9-901e-0036-1267-479b4c000000\nTime:2023-02-23T09:15:35.7547136Z</Message></Error>\r\n\r\nHeaders:\r\nServer: Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0\r\nx-ms-request-id: 7bf6d7b9-901e-0036-1267-479b4c000000\r\nx-ms-client-request-id: 6c89e4ee-0334-4b84-8229-4c9fe135272d\r\nx-ms-version: 2021-12-02\r\nx-ms-error-code: AuthorizationPermissionMismatch\r\nDate: Thu, 23 Feb 2023 09:15:34 GMT\r\nContent-Length: 279\r\nContent-Type: application/xml\r\n"
        // var message = e.Message.Split('\n').FirstOrDefault("");
        // Console.WriteLine($"Message: {message}");
    }

    public async Task WaitBlob(string endpoint)
    {
        var client = new BlobServiceClient(new Uri(endpoint), _credential);
        await WaitUntilSuccessAsync(() =>
        {
            client.GetBlobContainers()
                .ToList().ForEach(container =>
                    Console.Write(container.Name + " "));
        });
    }

    public async Task WaitCosmos(string endpoint)
    {
        var container = new CosmosClient(endpoint, _credential)
            .GetDatabase("OrderDB")
            .GetContainer("OrderData");
        await WaitUntilSuccessAsync(async () =>
        {
            var sql = "SELECT * from OrderData o";
            using var feed = container.GetItemQueryIterator<OrderData>(sql);
            while (feed.HasMoreResults)
            {
                var res = await feed.ReadNextAsync();
                foreach (var item in res) Console.WriteLine(item);
            }
        });
    }

    public async Task WaitKeyVault(string endpoint)
    {
        var client = new SecretClient(new Uri(endpoint), _credential);
        await WaitUntilSuccessAsync(() =>
        {
            client.GetPropertiesOfSecrets()
                .ToList().ForEach(secret =>
                    Console.Write(secret.Name + " "));
        });
    }

    public async Task WaitAppConfiguration(string endpoint)
    {
        var client = new ConfigurationClient(new Uri(endpoint), _credential);
        await WaitUntilSuccessAsync(() =>
        {
            client.GetConfigurationSettings()
                .ToList().ForEach(config =>
                    Console.Write(config + " "));
        });
    }

    private BlobClient BlobClient(string endpoint, string container, string path) =>
        new BlobServiceClient(new Uri(endpoint), _credential)
            .GetBlobContainerClient(container)
            .GetBlobClient(path);

    public void UploadBlob(string endpoint, string container, string path) =>
        BlobClient(endpoint, container, path).Upload(path, true);

    public void DownloadBlob(string endpoint, string container, string path) =>
        BlobClient(endpoint, container, path).DownloadTo(path);
}
