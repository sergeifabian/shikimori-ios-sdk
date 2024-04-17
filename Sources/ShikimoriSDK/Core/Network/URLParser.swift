import Foundation

struct URLParser {
  private let urlComponents: URLComponents

  init() {
    urlComponents = URLComponents()
  }

  init?(uri: String) {
    if let urlComponents = URLComponents(string: uri) {
      self.init(urlComponents: urlComponents)
    } else {
      return nil
    }
  }

  init(urlComponents: URLComponents) {
    self.urlComponents = urlComponents
  }

  func parseScheme() -> String? {
    urlComponents.scheme
  }
}

extension URLParser {
  static func parseCallbackURLScheme(configs: ShikimoriConfigs) -> String? {
    URLParser(uri: configs.redirectUri)?.parseScheme()
  }
}
