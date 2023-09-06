// リージョン
param location string = resourceGroup().location

// Application Insights名
param applicationInsightsName string = 'app-${uniqueString(resourceGroup().id)}'

// Log Analyticsワークスペース名
param logAnalyticsWorkspaceName string = 'log-${uniqueString(resourceGroup().id)}'

// サービスプリンシパルのID
param principalId string

// Log Analyticsワークスペース
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsWorkspaceName
  location: location
}

// Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'other'
  properties: {
    WorkspaceResourceId: logAnalyticsWorkspace.id
    Application_Type: 'other'
    DisableLocalAuth: true
  }
}

// ロール定義「Monitoring Metrics Publisher」
resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: subscription()
  name: '3913510d-42f4-4e42-8a64-420c390055eb'
}

// サービスプリンシパルにロールを割り当て
resource spRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: applicationInsights
  name: guid(applicationInsights.id, principalId, roleDef.name)
  properties: {
    roleDefinitionId: roleDef.id
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}

// 接続文字列を出力
output connectionString string = applicationInsights.properties.ConnectionString
