import 'dart:convert';

class RegisterPostModel {
  RegisterPostModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.countryCode,
    this.dob,
    this.source,
    this.uid,
    this.oneSignalPlayerId,
  });

  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? countryCode;
  final DateTime? dob;
  final String? source;
  final String? uid;
  final String? oneSignalPlayerId;

  factory RegisterPostModel.fromRawJson(String str) =>
      RegisterPostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterPostModel.fromJson(Map<String, dynamic> json) =>
      RegisterPostModel(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        password: json["password"] == null ? null : json["password"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        source: json["source"] == null ? null : json["source"],
        uid: json["uid"] == null ? null : json["uid"],
        oneSignalPlayerId: json["oneSignalPlayerId"] == null
            ? null
            : json["oneSignalPlayerId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "password": password == null ? null : password,
        "countryCode": countryCode == null ? null : countryCode,
        "dob": dob == null
            ? null
            : "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "source": source == null ? null : source,
        "uid": uid == null ? null : uid,
        "oneSignalPlayerId":
            oneSignalPlayerId == null ? null : oneSignalPlayerId,
      };
}
