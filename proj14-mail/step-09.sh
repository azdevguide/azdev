### Step 9: 動作確認

# メールを送信
dotnet run send-mail \
    --to "$AZDEV_MAIL_ADDRESS" \
    --subject 'test subject' \
    --body 'test body'

# 送信されたメールを確認してください
