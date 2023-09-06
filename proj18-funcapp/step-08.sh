### Step 8: 設定ファイルの作成

az storage account list -g $g \
    --query '{IsEncrypted:contains(`a`,`b`),
        Values:{
            AzureWebJobsStorage__accountName:[0].name,
            FUNCTIONS_WORKER_RUNTIME:`dotnet-isolated`
        }
    }' > local.settings.json
