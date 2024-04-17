import AuthenticationServices
import Foundation

final class AuthenticationController: NSObject {

  private var session: ASWebAuthenticationSession?

  let window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  func authenticate(url: URL, callbackURLScheme: String?, completion: @escaping (AuthenticationResult) -> Void) {
    let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackURLScheme) { url, error in
      if let url {
        completion(.completed(url))

      } else if let error = error as? ASWebAuthenticationSessionError {
        switch error.code {
        case .canceledLogin:
          completion(.canceled)

        case .presentationContextInvalid:
          completion(.error(.presentationContextInvalid))

        case .presentationContextNotProvided:
          completion(.error(.presentationContextNotProvided))

        @unknown default:
          completion(.error(.unknownSessionError(error)))
        }

      } else if let error {
        completion(.error(.unknownError(error)))

      } else {
        completion(.error(.invalidSessionParams))
      }
    }

    session.presentationContextProvider = self

    if session.canStart {
      session.start()

    } else {
      completion(.error(.invalidSessionConfigs))
    }

    self.session = session
  }
}

extension AuthenticationController: ASWebAuthenticationPresentationContextProviding {
  public func presentationAnchor(for _: ASWebAuthenticationSession) -> ASPresentationAnchor { window }
}
