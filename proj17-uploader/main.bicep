// リージョン
param location string = resourceGroup().location

// プラン名
param planName string = 'asp-${uniqueString(resourceGroup().id)}'

// アプリ名
param appName string = 'app-${uniqueString(resourceGroup().id)}'

// ストレージアカウント名
param storageAccountName string = 'st${uniqueString(resourceGroup().id)}'

// Blobコンテナー名
param blobContainerName string = 'images'

// サービスプリンシパルのID
param principalId string

// App Serviceプラン (Windows)
resource plan 'Microsoft.Web/serverfarms@2022-03-01' = {
  location: location
  name: planName
  sku: {
    name: 'F1'
  }
  kind: 'windows'
}

// App Serviceアプリ (Windows)
resource app 'Microsoft.Web/sites@2022-03-01' = {
  kind: 'app'
  location: location
  name: appName
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      netFrameworkVersion: 'v7.0'
      appSettings: [
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'blob__endpoint'
          value: '${storageAccount.properties.primaryEndpoints.blob}${blobContainerName}'
        }
      ]
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// App Serviceプラン (Linux)
// resource plan 'Microsoft.Web/serverfarms@2022-03-01' = {
//   location: location
//   name: planName
//   properties: {
//     reserved: true
//   }
//   sku: {
//     name: 'F1'
//   }
//   kind: 'linux'
// }

// App Serviceアプリ (Linux)
// resource app 'Microsoft.Web/sites@2022-03-01' = {
//   kind: 'app'
//   location: location
//   name: appName
//   properties: {
//     serverFarmId: plan.id
//     siteConfig: {
//       linuxFxVersion: 'DOTNETCORE|7.0'
//       appSettings: [
//         {
//           name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
//           value: 'true'
//         }
//         {
//           name: 'blob__serviceUri'
//           value: '${storageAccount.properties.primaryEndpoints.blob}/${blobContainerName}'
//         }
//       ]
//     }
//   }
//   identity: {
//     type: 'SystemAssigned'
//   }
// }

// ストレージアカウント
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

// Blobサービス
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  parent: storageAccount
  name: 'default'
}

// Blobコンテナー
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  name: blobContainerName
  parent: blobService
  properties: {
    publicAccess: 'Blob'
  }
}

// ロール定義「Storage Blob Data Contributor」
resource roleDef 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription()
  name: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
}

// App Serviceアプリのシステム割り当てマネージドIDにロールを割り当て
resource appRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, app.id, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: app.identity.principalId
    principalType: 'ServicePrincipal'
  }
}

// サービスプリンシパルにロールを割り当て
resource spRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, principalId, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

/*
metadata
https://github.com/Azure/bicep/issues/3314

Stackが空になる件
https://stackoverflow.com/questions/69897663/setting-azure-app-service-server-stack-on-a-bicep-template
*/
