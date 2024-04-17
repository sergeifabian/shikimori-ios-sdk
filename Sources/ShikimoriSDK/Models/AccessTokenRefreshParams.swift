struct AccessTokenRefreshParams: Encodable {
  let grantType = "refresh_token"
  let clientId: String
  let clientSecret: String
  let refreshToken: String

  init(configs: ShikimoriConfigs, refreshToken: String) {
    clientId = configs.clientId
    clientSecret = configs.clientSecret
    self.refreshToken = refreshToken
  }
}
