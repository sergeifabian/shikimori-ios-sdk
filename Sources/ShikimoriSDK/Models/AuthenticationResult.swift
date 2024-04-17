import Foundation

enum AuthenticationResult {
  case completed(URL)
  case canceled
  case error(AuthenticationError)
}
