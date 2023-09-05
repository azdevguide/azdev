### Step 1: プロジェクトの作成
dotnet new worker --force >> logs/dotnet-new.txt
rm {Program,Worker}.cs
touch {IMailSender,MailSender,Commands}.cs
