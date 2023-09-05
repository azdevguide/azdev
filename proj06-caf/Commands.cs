class Commands : ConsoleAppBase
{
    // コマンド(1)
    public void Hello(string name) =>
        Console.WriteLine($"Hello, {name}!");
    // コマンド(2)
    public void HelloWorld() =>
        Console.WriteLine("Hello, World!");
}