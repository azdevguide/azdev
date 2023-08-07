Environment.GetEnvironmentVariables()
.Cast<System.Collections.DictionaryEntry>()
.Select(kv => $"{kv.Key}={kv.Value}")
.Where(s => s.StartsWith("AZ"))
.Order()
.ToList().ForEach(Console.WriteLine);
