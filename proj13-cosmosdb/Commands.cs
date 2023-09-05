using Microsoft.Azure.Cosmos;

class Commands : ConsoleAppBase
{
    private readonly Container _container;
    public Commands(CosmosClient client) =>
        _container = client.GetDatabase("OrderDB")
            .GetContainer("OrderData");

    // ここにメソッドを追加していく

    // 項目の作成
    [Command("insert")]
    public Task InsertAsync(string customer, string id,
        Dictionary<string, int> orderDetail) =>
            _container.UpsertItemAsync(
                new OrderData(customer, id, orderDetail));

    // 項目の更新
    [Command("update")]
    public Task UpdateAsync(string customer, string id,
        Dictionary<string, int> orderDetail) =>
            InsertAsync(customer, id, orderDetail);

    // 項目の1件読み取り
    [Command("read")]
    public async Task ReadAsync(string customer, string id) =>
        Console.WriteLine((OrderData)await _container
            .ReadItemAsync<OrderData>(id, new PartitionKey(customer)));

    // 項目の全件検索
    public void SelectAll() =>
        _container.GetItemLinqQueryable<OrderData>(true)
            .ToList().ForEach(Console.WriteLine);

    // 項目の検索(顧客名を指定)
    public void SelectByCustomer(string customer) =>
        _container.GetItemLinqQueryable<OrderData>(true)
            .Where(orderData => orderData.Customer == customer)
            .ToList().ForEach(Console.WriteLine);

    // 項目の削除
    [Command("delete")]
    public Task DeleteAsync(string customer, string id) =>
        _container.DeleteItemAsync<OrderData>(
            id, new PartitionKey(customer));

}
