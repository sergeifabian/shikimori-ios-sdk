import Foundation

public struct AccessToken: Decodable {
  public let accessToken: String
  public let refreshToken: String
  public let createdAt: Date
  public let expiresAt: Date
  public let tokenType: String
  public let scope: String

  public init(accessToken: String, refreshToken: String, createdAt: Date, expiresAt: Date, tokenType: String, scope: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    self.createdAt = createdAt
    self.expiresAt = expiresAt
    self.tokenType = tokenType
    self.scope = scope
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decode(String.self, forKey: .accessToken)
    refreshToken = try container.decode(String.self, forKey: .refreshToken)
    createdAt = try container.decodeUnixDate(for: .createdAt)
    expiresAt = try container.decodeUnixDateWithInterval(for: .expiresAt, since: createdAt)
    tokenType = try container.decode(String.self, forKey: .tokenType)
    scope = try container.decode(String.self, forKey: .scope)
  }

  enum CodingKeys: String, CodingKey {
    case accessToken
    case refreshToken
    case createdAt
    case expiresAt = "expiresIn"
    case tokenType
    case scope
  }
}
