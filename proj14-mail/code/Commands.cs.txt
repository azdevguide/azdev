using MailService;

class Commands : ConsoleAppBase
{
    private readonly IMailSender _mailSender;
    public Commands(IMailSender mailSender) =>
        _mailSender = mailSender;
    public void SendMail(string to, string subject, string body) =>
        _mailSender.SendMail(to, subject, body);
}