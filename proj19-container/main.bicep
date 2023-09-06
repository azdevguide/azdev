// リージョン
param location string = resourceGroup().location

// コンテナーレジストリ名
param containerRegistoryName string = 'cr${uniqueString(resourceGroup().id)}'

// コンテナーグループ（コンテナーインスタンス）名
// param containerGroupName string = 'ci-${uniqueString(resourceGroup().id)}'

// ユーザー割り当てマネージドID名
param userAssignedManagedIdName string = 'id-${uniqueString(resourceGroup().id)}'

// ユーザー割り当てマネージドID
resource userAssignedManagedId 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
  name: userAssignedManagedIdName
  location: location
}

// コンテナーレジストリ
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  location: location
  name: containerRegistoryName
  sku: {
    name: 'Basic'
  }
  properties: {
  }
}

// コンテナーグループ
// resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2022-09-01' = {
//   location: location
//   name: containerGroupName
//   identity: {
//     type: 'UserAssigned'
//     userAssignedIdentities: {
//       '${resourceId('Microsoft.ManagedIdentity/userAssignedIdentities', userAssignedManagedId.name)}': {}
//     }
//   }
//   properties: {
//     containers: [
//       {
//         name: containerGroupName
//         properties: {
//           environmentVariables: []
//           image: 'hello-world'
//           resources: {
//             requests: {
//               cpu: 1
//               memoryInGB: 1
//             }
//           }
//         }
//       }
//     ]
//     initContainers: []
//     osType: 'Linux'
//     restartPolicy: 'Never'
//     sku: 'Standard'
//   }
// }

// ロール定義「AcrPull」
resource roleDef 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription()
  name: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
}

// ロール割り当て
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: containerRegistry
  name: guid(containerRegistry.id, userAssignedManagedId.id, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: userAssignedManagedId.properties.principalId
    principalType: 'ServicePrincipal'
  }
}
