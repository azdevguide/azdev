// 通信サービスのリソース名
param communicationServicesName string = 'commsv${uniqueString(resourceGroup().id)}'

// Eメールサービスのリソース名
param emailServicesName string = 'emailsv${uniqueString(resourceGroup().id)}'

// Eメールサービスのドメイン名
param emailDomainName string = 'AzureManagedDomain' // この名前でなければならない

// サービスプリンシパルのID
param principalId string

// リージョン
param location string = 'global'

// データの場所
// param dataLocation string = 'United States'
param dataLocation string = 'Japan'

// メール通信サービス
resource emailServices 'Microsoft.Communication/emailServices@2023-03-31' = {
  name: emailServicesName
  location: location
  properties: {
    dataLocation: dataLocation
  }

  // メール通信サービス ドメイン
  resource emailDomain 'domains' = {
    name: emailDomainName
    location: location
    properties: {
      domainManagement: 'AzureManaged'
      userEngagementTracking: 'Disabled'
    }
  }

}

// 通信サービス
resource communicationServices 'Microsoft.Communication/communicationServices@2023-03-31' = {
  name: communicationServicesName
  location: location
  properties: {
    dataLocation: dataLocation
    linkedDomains: [
      emailServices::emailDomain.id
    ]
  }
}

// 組み込みのロール「Contributor」のロール定義
resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
}

// 通信サービス スコープで、サービスプリンシパルにロールを割り当て
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: communicationServices
  name: guid(communicationServices.id, principalId, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

// 決定したドメイン名、ホスト名などを出力
output fromSenderDomain string = emailServices::emailDomain.properties.fromSenderDomain
output mailFromSenderDomain string = emailServices::emailDomain.properties.mailFromSenderDomain
output hostName string = communicationServices.properties.hostName
output doNotReply string = 'donotreply'
