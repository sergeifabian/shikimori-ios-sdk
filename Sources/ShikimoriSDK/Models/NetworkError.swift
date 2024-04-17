import Foundation

public enum NetworkError: Error {
  case encodingError(EncodingError)
  case decodingError(DecodingError)
  case sessionError(Error)
  case unknown(Error)
  case invalidResponse(HTTPURLResponse)
  case invalidSessionTaskParams
}
