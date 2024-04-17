import Foundation

public enum AuthorizationCodeGetError: Error {
  case invalidRedirectURL(URL)
  case authenticationError(AuthenticationError)
}
