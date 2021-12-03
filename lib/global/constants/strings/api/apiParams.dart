//*Api Parameter values
class ParameterContentType {
  static const formURLEncoded = "application/x-www-form-urlencoded";
  static const plaintText = "text/plain";
  static const multipartForm = "multipart/form-data";
  static const json = "application/json";
  static const none = "";
}

//*Api Header Keys
class HTTPHeaderKeys {
  static const contentType = "Content-Type";
  static const accept = "Accept";
  static const authorization = "Authorization";
}

class AuthKeyData {
  static const email = "email";
  static const password = "password";
  static const phoneNumber = "phoneNumber";
  static const countryCode = "countryCode";
  static const fullName = "name";
  static const dateOfBirth = "dob";
  static const source = "source";
  static const uid = 'uid';
  static const oneSignalPlayerId = "oneSignalPlayerId";
}
