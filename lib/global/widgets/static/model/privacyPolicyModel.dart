import 'dart:convert';

class PolicyModel {
  PolicyModel({
    this.data,
    this.message,
  });

  final String? data;
  final String? message;

  factory PolicyModel.fromRawJson(String str) =>
      PolicyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PolicyModel.fromJson(Map<String, dynamic> json) =>
      PolicyModel(
        data: json["data"] == null ? null : json["data"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data,
        "message": message == null ? null : message,
      };
}
