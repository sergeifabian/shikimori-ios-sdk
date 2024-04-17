import Foundation

final class AccessTokenDataSource {

  private let networkController = NetworkController()

  func fetchAccessToken(params: AccessTokenFetchParams, configs: ShikimoriConfigs, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
    networkController.fetchAccessToken(params: params, configs: configs, completion: completion)
  }

  func refreshAccessToken(params: AccessTokenRefreshParams, configs: ShikimoriConfigs, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
    networkController.refreshAccessToken(params: params, configs: configs, completion: completion)
  }
}
