namespace MailService;

public class MailSender : IMailSender
{
    public void SendMail(string to, string subject, string body)
    {
        Console.WriteLine($"送信先: {to}");
        Console.WriteLine($"件名: {subject}");
        Console.WriteLine($"本文: {body}");
        Console.WriteLine("メールを送信しました");
    }
}