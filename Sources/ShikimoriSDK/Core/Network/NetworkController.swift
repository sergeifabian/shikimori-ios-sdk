import Foundation

final class NetworkController {
  func fetchAccessToken(params: AccessTokenFetchParams, configs: ShikimoriConfigs, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
    let url = URLBuilder.buildAuthenticationURL(configs: configs)
    request(url: url, headers: configs.headers, params: params, completion: completion)
  }

  func refreshAccessToken(params: AccessTokenRefreshParams, configs: ShikimoriConfigs, completion: @escaping (Result<AccessToken, NetworkError>) -> Void) {
    let url = URLBuilder.buildAuthenticationURL(configs: configs)
    request(url: url, headers: configs.headers, params: params, completion: completion)
  }

  private func request<P: Encodable, R: Decodable>(url: URL, headers: [String: String], params: P, completion: @escaping (Result<R, NetworkError>) -> Void) {
    do {
      let request = try URLRequestBuilder(url: url)
        .addPostMethod()
        .addHeaders(headers)
        .addBody(params)
        .build()

      let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error {
          completion(.failure(.sessionError(error)))

        } else if let data {

          do {
            try completion(
              .success(
                URLResponseParser(data: data)
                  .parseBody(R.self)
              )
            )

          } catch let error as DecodingError {
            completion(.failure(.decodingError(error)))

          } catch {
            completion(.failure(.unknown(error)))
          }

        } else if let response = response as? HTTPURLResponse {
          completion(.failure(.invalidResponse(response)))

        } else {
          completion(.failure(.invalidSessionTaskParams))
        }
      }

      task.resume()

    } catch let error as EncodingError {
      completion(.failure(.encodingError(error)))

    } catch {
      completion(.failure(.unknown(error)))
    }
  }
}
