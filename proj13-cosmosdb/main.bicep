// リージョン
param location string = resourceGroup().location

// アカウント名
param accountName string = 'cosmos${uniqueString(resourceGroup().id)}'

// データベース名
param dbName string = 'OrderDB'

// コンテナー名
param containerName string = 'OrderData'

// サービスプリンシパル名
param principalId string

// Cosmos DBアカウント
resource account 'Microsoft.DocumentDB/databaseAccounts@2023-04-15' = {
  name: accountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        isZoneRedundant: false
        failoverPriority: 0
      }
    ]
  }

  // Cosmos DB データベース
  resource db 'sqlDatabases' = {
    name: dbName
    properties: {
      resource: {
        id: dbName
      }
    }

    // Cosmos DB コンテナー
    resource container 'containers' = {
      name: containerName
      properties: {
        resource: {
          id: containerName
          partitionKey: {
            kind: 'Hash'
            paths: [
              '/Customer'
            ]
          }
        }
      }
    }
  }

  // 組み込みのロール「Cosmos DB 組み込みデータ共同作成者」のロール定義
  resource roleDef 'sqlRoleDefinitions' existing = {
    name: '00000000-0000-0000-0000-000000000002'
  }

  // ロールの割り当て
  resource roleAssignment 'sqlRoleAssignments' = {
    name: guid(account.id, principalId, roleDef.name)
    properties: {
      roleDefinitionId: roleDef.id
      principalId: principalId
      scope: account.id
    }
  }

}

// エンドポイントの出力
output endpoint string = account.properties.documentEndpoint
