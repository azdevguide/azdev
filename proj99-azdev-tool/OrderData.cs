using System.Text.Json;

record OrderData(
    string customer,
    string id,
    Dictionary<string, int> orderDetail
)
{
    public override string ToString() =>
        JsonSerializer.Serialize(this);
}