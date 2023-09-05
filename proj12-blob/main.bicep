// リージョン
param location string = resourceGroup().location

// ストレージアカウント名
param storageAccountName string = 'st${uniqueString(resourceGroup().id)}'

// Blobコンテナー名
param blobContainerName string = 'test'

// サービスプリンシパルのID
param principalId string

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

// 「Storage Blob Data Contributor」ロールの定義
resource roleDef 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription()
  name: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
}

// ロール割り当て
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(storageAccount.id, principalId, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

// エンドポイント
output endpoint string = '${storageAccount.properties.primaryEndpoints.blob}${blobContainerName}'
