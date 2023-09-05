### Step 7: 設定ファイルの作成

voice='ja-JP-NanamiNeural'
# voice='ja-JP-KeitaNeural'
output='output.wav'
# output='speaker'
az deployment group show -n $g -g $g \
    --query "{speech:{
        resourceId: properties.outputs.resourceId.value,
        region: '$l',
        language: 'ja-JP',
        voiceName: '$voice',
        output: '$output'}}" > appsettings.json
