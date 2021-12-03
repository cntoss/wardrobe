import 'dart:convert';

class AuthCheckModel {
  AuthCheckModel({
    this.data,
    this.message,
  });

  final dynamic data;
  final String? message;

  factory AuthCheckModel.fromRawJson(String str) =>
      AuthCheckModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthCheckModel.fromJson(Map<String, dynamic> json) => AuthCheckModel(
        data: json["data"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message == null ? null : message,
      };
}
