// リージョン
param location string = resourceGroup().location

// 名前
param name string = 'cog-speech-${uniqueString(resourceGroup().id)}'

// サービスプリンシパルのID
param principalId string

// Cognitive Service アカウント
resource speech 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  kind: 'SpeechServices'
  location: location
  name: name
  properties: {
    customSubDomainName: name
  }
  sku: {
    name: 'F0'
  }
}

// ロール「Cognitive Services User」
resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: 'f2dc8367-1007-4938-bd23-fe263f013447'
}

// ロール割り当て
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: speech
  name: guid(speech.id, principalId, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

output resourceId string = speech.id
