// 追加ここから
using Microsoft.ApplicationInsights;
// 追加ここまで

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace proj21_appinsights_webapp.Pages;

public class IndexModel : PageModel
{
    // 追加ここから
    private readonly TelemetryClient _tc;
    // 追加ここまで
    private readonly ILogger<IndexModel> _logger;

    // 変更ここから
    public IndexModel(ILogger<IndexModel> logger, TelemetryClient tc) =>
        (_logger, _tc) = (logger, tc);
    public void OnGet()
    {
        // トランザクションの CUSTOM EVENT として記録される
        _tc.TrackEvent("カスタムイベントの例",
            new Dictionary<string, string>
            {
                { "methodName", nameof(OnGet) }
            });
        try
        {
            throw new NullReferenceException("これはテストです");
        }
        catch (Exception e)
        {
            _logger.LogError(e, "IndexModelで捕捉した例外");
        }
    }
    // 変更ここまで
}
