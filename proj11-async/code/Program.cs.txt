var util = new FileUtil("test.txt");
Console.WriteLine(util.Read());
Console.WriteLine(await util.ReadAsync());

class FileUtil
{
    private readonly string _path;
    public FileUtil(string path) => _path = path;
    // 同期版のメソッド
    public string Read()
    {
        var text = File.ReadAllText(_path);
        return text;
    }
    // 非同期版のメソッド
    public async Task<string> ReadAsync()
    {
        var text = await File.ReadAllTextAsync(_path);
        return text;
    }
}