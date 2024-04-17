import Foundation

public struct ShikimoriConfigs {
  let scheme: String
  let host: String
  let authorizationPath: String
  let authenticationPath: String
  let apiPath: String
  let appName: String
  let clientId: String
  let clientSecret: String
  let redirectUri: String
  let scopes: String

  var authorizationParams: [String: String] {
    [
      "client_id": clientId,
      "redirect_uri": redirectUri,
      "response_type": "code"
    ]
  }

  var headers: [String: String] {
    [
      "User-Agent": appName,
      "Content-Type": "application/json"
    ]
  }

  public init(
    scheme: String = "https",
    host: String = "shikimori.one",
    authorizationPath: String = "/oauth/authorize",
    authenticationPath: String = "/oauth/token",
    apiPath: String = "/api",
    appName: String,
    clientId: String,
    clientSecret: String,
    redirectUri: String,
    scopes: [Scope] = []
  ) {
    self.scheme = scheme
    self.host = host
    self.authorizationPath = authorizationPath
    self.authenticationPath = authenticationPath
    self.apiPath = apiPath
    self.appName = appName
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.redirectUri = redirectUri
    self.scopes = scopes.asParams
  }
}

public extension ShikimoriConfigs {
  enum Scope: String {
    case userRates = "user_rates"
    case email
    case messages
    case comments
    case topics
    case content
    case clubs
    case friends
    case ignores
  }
}

private extension Array where Element == ShikimoriConfigs.Scope {
  var asParams: String { map { $0.rawValue }.joined(separator: "+") }
}
