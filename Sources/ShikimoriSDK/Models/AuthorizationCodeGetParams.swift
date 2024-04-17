import Foundation

struct AuthorizationCodeGetParams {
  let url: URL
  let callbackURLScheme: String?

  init(url: URL, callbackURLScheme: String?) {
    self.url = url
    self.callbackURLScheme = callbackURLScheme
  }

  init(configs: ShikimoriConfigs) {
    url = URLBuilder.buildAuthorizationURL(configs: configs)
    callbackURLScheme = URLParser.parseCallbackURLScheme(configs: configs)
  }
}
