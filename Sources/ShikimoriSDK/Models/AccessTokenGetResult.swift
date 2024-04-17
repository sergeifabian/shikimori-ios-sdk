public enum AccessTokenGetResult {
  case completed(AccessToken)
  case canceled
  case error(AccessTokenGetError)
}
