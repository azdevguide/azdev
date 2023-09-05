// リージョン
param location string = resourceGroup().location

// 名前
param name string = 'cog-cv-${uniqueString(resourceGroup().id)}'

// ロール「Cognitive Services User」のID
param roleDefinitionResourceId string= 'a97b65f3-24c7-4388-baec-2e87135dc908'

// サービスプリンシパルのID
param principalId string

// Cognitive Service アカウント
resource cv 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  kind: 'ComputerVision'
  location: location
  name: name
  properties: {
    customSubDomainName: name
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'F0'
  }
}

// ロール定義
resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: roleDefinitionResourceId
}

// ロール割り当て
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: cv
  name: guid(cv.id, principalId, roleDefinitionResourceId)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

// エンドポイントを出力
output endpoint string = cv.properties.endpoint
