import Foundation

final class AccessTokenRefreshUseCase {

  private let accessTokenDataSource = AccessTokenDataSource()

  func execute(configs: ShikimoriConfigs, accessToken: AccessToken, completion: @escaping (AccessTokenRefreshResult) -> Void) {
    refreshAccessToken(configs: configs, accessToken: accessToken) { result in
      switch result {
      case .success(let accessToken):
        completion(.completed(accessToken))
        
      case .failure(let error):
        completion(.error(.networkError(error)))
      }
    }
  }

  func refreshAccessToken(configs: ShikimoriConfigs, accessToken: AccessToken, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
    let params = AccessTokenRefreshParams(configs: configs, refreshToken: accessToken.refreshToken)
    accessTokenDataSource.refreshAccessToken(params: params, configs: configs, completion: completion)
  }
}
