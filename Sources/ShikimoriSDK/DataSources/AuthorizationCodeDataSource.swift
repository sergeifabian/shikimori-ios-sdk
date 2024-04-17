import UIKit

final class AuthorizationCodeDataSource {

  private let authenticationController: AuthenticationController

  init(window: UIWindow) {
    self.authenticationController = AuthenticationController(window: window)
  }

  func getAuthorizationCode(params: AuthorizationCodeGetParams, completion: @escaping (AuthorizationCodeGetResult) -> Void) {
    authenticationController.authenticate(url: params.url, callbackURLScheme: params.callbackURLScheme) { result in
      switch result {
      case .completed(let url):
        if let authorizationCode = AuthorizationCode(url: url) {
          completion(.completed(authorizationCode))

        } else {
          completion(.error(.invalidRedirectURL(url)))
        }

      case .canceled:
        completion(.canceled)

      case .error(let error):
        completion(.error(.authenticationError(error)))
      }
    }
  }
}
