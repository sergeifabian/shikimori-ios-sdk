enum AuthorizationCodeGetResult {
  case completed(AuthorizationCode)
  case canceled
  case error(AuthorizationCodeGetError)
}
