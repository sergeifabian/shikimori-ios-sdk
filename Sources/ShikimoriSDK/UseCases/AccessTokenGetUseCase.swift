import UIKit

final class AccessTokenGetUseCase {

  private let authorizationCodeDataSource: AuthorizationCodeDataSource
  private let accessTokenDataSource: AccessTokenDataSource

  init(window: UIWindow) {
    self.authorizationCodeDataSource = AuthorizationCodeDataSource(window: window)
    self.accessTokenDataSource = AccessTokenDataSource()
  }

  func execute(configs: ShikimoriConfigs, completion: @escaping (AccessTokenGetResult) -> Void) {
    getAuthorizationCode(configs: configs) { [weak self] result in
      switch result {
      case .completed(let authorizationCode):
        self?.fetchAccessToken(configs: configs, authorizationCode: authorizationCode) { result in
          switch result {
          case .success(let accessToken):
            completion(.completed(accessToken))

          case .failure(let error):
            completion(.error(.networkError(error)))
          }
        }

      case .canceled:
        completion(.canceled)

      case .error(let error):
        completion(.error(.authorizationCodeGetError(error)))
      }
    }
  }

  private func getAuthorizationCode(configs: ShikimoriConfigs, completion: @escaping (AuthorizationCodeGetResult) -> Void) {
    let params = AuthorizationCodeGetParams(configs: configs)
    authorizationCodeDataSource.getAuthorizationCode(params: params, completion: completion)
  }

  private func fetchAccessToken(configs: ShikimoriConfigs, authorizationCode: AuthorizationCode, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
    let params = AccessTokenFetchParams(configs: configs, code: authorizationCode.code)
    accessTokenDataSource.fetchAccessToken(params: params, configs: configs, completion: completion)
  }
}
