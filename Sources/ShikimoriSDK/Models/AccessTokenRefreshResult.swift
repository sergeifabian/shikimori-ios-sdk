public enum AccessTokenRefreshResult {
  case completed(AccessToken)
  case error(AccessTokenRefreshError)
}
