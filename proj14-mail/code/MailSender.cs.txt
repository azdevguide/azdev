using Azure.Communication.Email;

namespace MailService;
public class MailSender : IMailSender
{
    private readonly EmailClient _emailClient;
    private readonly string _sender;
    public MailSender(EmailClient emailClient, IConfiguration config)
    {
        _emailClient = emailClient;
        var user = config["mail:user"];
        var domain = config["mail:domain"];
        _sender = $"{user}@{domain}";
    }
    public void SendMail(string to, string subject, string body)
    {
        var content = new EmailContent(subject) { PlainText = body };
        var email = new EmailAddress(to);
        var recipients = new EmailRecipients(new[] { email });
        var message = new EmailMessage(_sender, recipients, content);
        _emailClient.Send(Azure.WaitUntil.Started, message);
    }
}
