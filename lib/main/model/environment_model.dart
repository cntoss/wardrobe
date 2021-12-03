enum AppEnvironment { development, production }

class EnvironmentModel {
  String appTitle;
  String apiUrl;
  String baseUrl;
  String environment;
  String platform;
  String mapAPIKey;
  String baatoAPIKey;
  String? token;
  String? username;
  bool? verified;
  bool? phoneVerified;
  String? name;
  String? phoneNo;
  String? countryCode;
  String? email;
  String appVersion;
  String oneSignalAppId;
  String? oneSignalPlayerId;
  String appBuildNumber;
  String? ip;


  EnvironmentModel({
    required this.appTitle,
    required this.baseUrl,
    required this.mapAPIKey,
    required this.apiUrl,
    required this.oneSignalAppId,
    required this.environment,
    required this.platform,
    required this.appVersion,
    required this.appBuildNumber,
    required this.baatoAPIKey,
    required this.ip,
    this.token,
    this.oneSignalPlayerId,
    this.username,
    this.name,
    this.phoneNo,
    this.email,
    this.verified,
    this.phoneVerified,
    this.countryCode,
  });

  set tokenSet(String? token) {
    this.token = token;
  }

  String? get tokenValue => token;

  set usernameSet(String? username) {
    this.username = username;
  }

  set nameSet(String name) {
    this.name = name;
  }

  set phoneSet(String? phone) {
    phoneNo = phone;
  }

  set emailSet(String email) {
    this.email = email;
  }

  set verifiedSet(bool verified) {
    this.verified = verified;
  }

  set phoneVerifiedSet(bool phoneVerified) {
    this.phoneVerified = phoneVerified;
  }

  set countryCodeSet(String countryCode) {
    this.countryCode = countryCode;
  }
}
