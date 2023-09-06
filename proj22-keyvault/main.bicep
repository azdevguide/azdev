// リージョン
param location string = resourceGroup().location

// サービスプリンシパルのID
param principalId string

// Key Vault名
param keyVaultName string = 'kv-${uniqueString(resourceGroup().id)}'

// Key Vault キーコンテナー
resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
  }
}

// ロール定義「Key Vault Secrets User」
resource userRoleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: '4633458b-17de-408a-b874-0445c86b69e6'
}

// サービスプリンシパルに「Key Vault Secrets User」ロールを割り当て
resource spRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: keyVault
  name: guid(keyVault.id, principalId, userRoleDef.name)
  properties: {
    roleDefinitionId: userRoleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
