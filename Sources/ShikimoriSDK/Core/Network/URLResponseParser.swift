import Foundation

struct URLResponseParser {
  private let data: Data

  init(data: Data) {
    self.data = data
  }

  func parseBody<T: Decodable>(_ bodyType: T.Type = T.self) throws -> T {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(bodyType, from: data)
  }
}
