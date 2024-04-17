import Foundation

struct URLRequestBuilder {
  private let urlRequest: URLRequest

  init(urlRequest: URLRequest) {
    self.urlRequest = urlRequest
  }

  init(url: URL) {
    urlRequest = URLRequest(url: url)
  }

  func addMethod(_ httpMethod: String?) -> URLRequestBuilder {
    mutate { $0.httpMethod = httpMethod }
  }

  func addPostMethod() -> URLRequestBuilder {
    addMethod("POST")
  }

  func addHeaders(_ httpHeaderFields: [String: String]) -> URLRequestBuilder {
    mutate {
      if let allHTTPHeaderFields = $0.allHTTPHeaderFields {
        $0.allHTTPHeaderFields = allHTTPHeaderFields.merging(httpHeaderFields, uniquingKeysWith: { _, new in new })
      } else {
        $0.allHTTPHeaderFields = httpHeaderFields
      }
    }
  }

  func addBody<T: Encodable>(_ value: T) throws -> URLRequestBuilder {
    try mutate {
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      $0.httpBody = try encoder.encode(value)
    }
  }

  func build() -> URLRequest {
    urlRequest
  }

  private func mutate(block: (inout URLRequest) throws -> Void) rethrows -> URLRequestBuilder {
    var urlRequest = urlRequest
    try block(&urlRequest)
    return URLRequestBuilder(urlRequest: urlRequest)
  }
}
