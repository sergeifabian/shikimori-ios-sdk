import Foundation

struct AccessTokenFetchParams: Encodable {
  let grantType = "authorization_code"
  let clientId: String
  let clientSecret: String
  let redirectUri: String
  let code: String

  init(configs: ShikimoriConfigs, code: String) {
    clientId = configs.clientId
    clientSecret = configs.clientSecret
    redirectUri = configs.redirectUri
    self.code = code
  }
}
