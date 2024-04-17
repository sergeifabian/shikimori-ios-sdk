import UIKit

public final class ShikimoriSDK {

  let accessTokenGetUseCase: AccessTokenGetUseCase
  let accessTokenRefreshUseCase: AccessTokenRefreshUseCase

  public init(window: UIWindow) {
    accessTokenGetUseCase = AccessTokenGetUseCase(window: window)
    accessTokenRefreshUseCase = AccessTokenRefreshUseCase()
  }

  public func getAccessToken(configs: ShikimoriConfigs, completion: @escaping (AccessTokenGetResult) -> Void) {
    accessTokenGetUseCase.execute(configs: configs) { result in
      DispatchQueue.main.async {
        completion(result)
      }
    }
  }

  public func refreshAccessToken(configs: ShikimoriConfigs, accessToken: AccessToken, completion: @escaping (AccessTokenRefreshResult) -> Void) {
    accessTokenRefreshUseCase.execute(configs: configs, accessToken: accessToken) { result in
      DispatchQueue.main.async {
        completion(result)
      }
    }
  }
}
