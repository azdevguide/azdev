using Azure.Storage.Blobs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
namespace Uploader.Pages;

public class IndexModel : PageModel
{
    public IFormFile? Image { get; set; }
    public IEnumerable<string> Urls { get; set; } =
        Enumerable.Empty<string>();
    private readonly BlobContainerClient _client;
    public IndexModel(BlobContainerClient client) => _client = client;
    public void OnGet() =>
        Urls = _client.GetBlobs()
            .OrderByDescending(blob => blob.Properties.CreatedOn)
            .Select(blob => _client.Uri + "/" + blob.Name);
    public ActionResult OnPost()
    {
        if (Image is not null)
            _client.UploadBlob(Guid.NewGuid().ToString(),
                Image.OpenReadStream());
        return Redirect("~/");
    }
}
