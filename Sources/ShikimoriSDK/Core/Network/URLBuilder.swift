import Foundation

struct URLBuilder {
  private let urlComponents: URLComponents

  init() {
    urlComponents = URLComponents()
  }

  init(urlComponents: URLComponents) {
    self.urlComponents = urlComponents
  }

  func addScheme(_ scheme: String) -> URLBuilder {
    mutate { $0.scheme = scheme }
  }

  func addHost(_ host: String) -> URLBuilder {
    mutate { $0.host = host }
  }

  func addPath(_ path: String) -> URLBuilder {
    mutate { $0.path = path }
  }

  func addParams(_ params: [String: String]) -> URLBuilder {
    mutate { $0.queryItems = params.map(URLQueryItem.init) }
  }

  func build() -> URL {
    if let url = urlComponents.url {
      return url
    } else {
      assertionFailure("Can't build URL")
      return URL(fileURLWithPath: "")
    }
  }

  private func mutate(block: (inout URLComponents) -> Void) -> URLBuilder {
    var urlComponents = urlComponents
    block(&urlComponents)
    return URLBuilder(urlComponents: urlComponents)
  }
}

extension URLBuilder {
  static func buildDomainURL(configs: ShikimoriConfigs) -> URL {
    URLBuilder()
      .addScheme(configs.scheme)
      .addHost(configs.host)
      .build()
  }

  static func buildAuthorizationURL(configs: ShikimoriConfigs) -> URL {
    URLBuilder()
      .addScheme(configs.scheme)
      .addHost(configs.host)
      .addPath(configs.authorizationPath)
      .addParams(configs.authorizationParams)
      .build()
  }

  static func buildAuthenticationURL(configs: ShikimoriConfigs) -> URL {
    URLBuilder()
      .addScheme(configs.scheme)
      .addHost(configs.host)
      .addPath(configs.authenticationPath)
      .build()
  }

  static func buildApiURL(configs: ShikimoriConfigs) -> URL {
      URLBuilder()
      .addScheme(configs.scheme)
      .addHost(configs.host)
      .addPath(configs.apiPath)
      .build()
  }
}
