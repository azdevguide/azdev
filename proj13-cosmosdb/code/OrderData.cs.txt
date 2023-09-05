using System.Text.Json;

#pragma warning disable IDE1006

record OrderData(
    string Customer, string id,
    Dictionary<string, int> OrderDetail)
{
    public override string ToString() =>
        JsonSerializer.Serialize(this);
}
