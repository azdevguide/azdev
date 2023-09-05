using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MailService;
namespace WebAppSample1.Pages;
public class SampleModel : PageModel
{
    private readonly ILogger<SampleModel> _logger;
    private readonly IMailSender _mailSender;
    private readonly IConfiguration _config;
    public SampleModel(IMailSender mailSender,
        ILogger<SampleModel> logger, IConfiguration config) =>
        (_mailSender, _logger, _config) = (mailSender, logger, config);
    public void OnGet()
    {
        var message = _config["MYCONFIG_MESSAGE"];
        _logger.LogInformation("message: {}", message);
        _mailSender.SendMail(
            "test@example.com",
            "test",
            "this is a test mail from SampleModel.OnGet");
    }
}
