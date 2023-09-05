using MailService;

class Commands
{
    private readonly IMailSender _mailSender;
    public Commands(IMailSender mailSender) =>
        _mailSender = mailSender;
    public void SendTestMail() =>
        _mailSender.SendMail(
            "test@example.com",
            "test",
            "this is a test mail.");
}