public enum AuthenticationError: Error {
  case unknownError(Error)
  case unknownSessionError(Error)
  case invalidSessionParams
  case invalidSessionConfigs
  case presentationContextInvalid
  case presentationContextNotProvided
}
