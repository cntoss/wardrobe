import 'dart:convert';

class LoginModel {
  LoginModel({
    this.email,
    this.phoneNumber,
    this.password,
    this.countryCode,
    this.source,
    this.oneSignalPlayerId,
  });

  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? countryCode;
  final String? source;
  final String? oneSignalPlayerId;

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        password: json["password"] == null ? null : json["password"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        source: json["source"] == null ? null : json["source"],
        oneSignalPlayerId: json["oneSignalPlayerId"] == null
            ? null
            : json["oneSignalPlayerId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null || email == "" ? null : email,
        "phoneNumber":
            phoneNumber == null || phoneNumber == "" ? null : phoneNumber,
        "password": password == null || password == "" ? null : password,
        "countryCode":
            countryCode == null || countryCode == "" ? null : countryCode,
        "source": source == null || source == "" ? null : source,
        "oneSignalPlayerId":
            oneSignalPlayerId == null || oneSignalPlayerId == ""
                ? null
                : oneSignalPlayerId,
      };
}
