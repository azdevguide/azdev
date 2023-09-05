### Step 8: 動作確認

if [ -f $output ]; then rm $output; fi
dotnet run speech --message 'みなさん、おはようございます'
