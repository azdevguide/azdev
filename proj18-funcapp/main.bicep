
// リージョン
param location string = resourceGroup().location

// ストレージアカウント名
param storageAccountName string = 'st${uniqueString(resourceGroup().id)}'

// サービスプリンシパルのID
param principalId string

// Azure Functions プラン名
param planName string = 'asp-${uniqueString(resourceGroup().id)}'

// Azure Functions アプリ名
param appName string = 'app-${uniqueString(resourceGroup().id)}'

// ==================================================================

// ストレージアカウント
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }

  // Blobサービス
  resource blobService 'blobServices' = {
    name: 'default'

    // Blobコンテナー「input」
    resource inputContainer 'containers' = {
      name: 'input'
    }
    // Blobコンテナー「output」
    resource outputContainer 'containers' = {
      name: 'output'
    }
  }
}

// ストレージ BLOB データ所有者  b7e6dc6d-f1e8-4753-8033-0f276bb0955b
resource roleDef1 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
}

// ストレージ アカウント共同作成者 17d1049b-9a84-46fb-8f53-869881c3d3ab
resource roleDef2 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: '17d1049b-9a84-46fb-8f53-869881c3d3ab'
}

// ストレージ キュー データ共同作成者 974c5e8b-45b9-4653-ba55-5f855dd0fb88
resource roleDef3 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: '974c5e8b-45b9-4653-ba55-5f855dd0fb88'
}

// サービスプリンシパルへのロール割り当て1
resource spRoleAssignment1 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, principalId, roleDef1.name)
  properties: {
    roleDefinitionId: roleDef1.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

// サービスプリンシパルへのロール割り当て2
resource spRoleAssignment2 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, principalId, roleDef2.name)
  properties: {
    roleDefinitionId: roleDef2.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

// サービスプリンシパルへのロール割り当て3
resource spRoleAssignment3 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, principalId, roleDef3.name)
  properties: {
    roleDefinitionId: roleDef3.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}


// ==================================================================


// Azure Functions プラン
resource hostingPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: planName
  location: location
  sku: { name: 'Y1', tier: 'Dynamic' }
}

// Azure Functions 関数アプリ
resource funcApp 'Microsoft.Web/sites@2022-03-01' = {
  kind: 'functionapp'
  location: location
  name: appName
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      netFrameworkVersion: 'v7.0'
      appSettings: [
        {
          name: 'AzureWebJobsStorage__accountName'
          value: storageAccountName
        }

        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(appName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet-isolated'
        }
      ]
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}


// ロール割り当て1
resource funcRoleAssignment1 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, funcApp.name, roleDef1.name)
  properties: {
    roleDefinitionId: roleDef1.id
    principalId: funcApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}
// ロール割り当て2
resource funcRoleAssignment2 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, funcApp.name, roleDef2.name)
  properties: {
    roleDefinitionId: roleDef2.id
    principalId: funcApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}
// ロール割り当て3
resource funcRoleAssignment3 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, funcApp.name, roleDef3.name)
  properties: {
    roleDefinitionId: roleDef3.id
    principalId: funcApp.identity.principalId
    principalType: 'ServicePrincipal'
  }
}
