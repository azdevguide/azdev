using Azure.Storage.Blobs;
class Commands : ConsoleAppBase
{
    // Blobコンテナーのクライアント
    private readonly BlobContainerClient _client;
    // コンストラクタ
    public Commands(BlobContainerClient client) => _client = client;
    // Blob操作用のBlobClientを取得する補助メソッド
    private BlobClient Blob(string path) => _client.GetBlobClient(path);
    // Blobアップロード
    public void Upload(string path) => Blob(path).Upload(path, true);
    // Blobダウンロード
    public void Download(string path) => Blob(path).DownloadTo(path);
    // Blob削除
    public void Delete(string path) => Blob(path).Delete();
    // Blob一覧
    public void List() =>
        _client.GetBlobs().ToList()
            .ForEach(blob => Console.WriteLine(blob.Name));
}