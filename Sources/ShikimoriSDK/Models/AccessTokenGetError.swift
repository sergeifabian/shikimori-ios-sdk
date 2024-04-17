public enum AccessTokenGetError: Error {
  case authorizationCodeGetError(AuthorizationCodeGetError)
  case networkError(NetworkError)
}
