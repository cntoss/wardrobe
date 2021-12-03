import 'dart:convert';

class SocialPostModel {
  SocialPostModel({
    this.inputToken,
    this.profile,
    this.source,
    this.oneSignalPlayerId,
  });

  final String? inputToken;
  final Profile? profile;
  final String? source;
  final String? oneSignalPlayerId;

  factory SocialPostModel.fromRawJson(String str) =>
      SocialPostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SocialPostModel.fromJson(Map<String, dynamic> json) =>
      SocialPostModel(
        inputToken: json["inputToken"] == null ? null : json["inputToken"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        source: json["source"] == null ? null : json["source"],
        oneSignalPlayerId: json["oneSignalPlayerId"],
      );

  Map<String, dynamic> toJson() => {
        "inputToken": inputToken == null ? null : inputToken,
        "profile": profile == null ? null : profile!.toJson(),
        "source": source == null ? null : source,
        "oneSignalPlayerId": oneSignalPlayerId,
      };
}

class Profile {
  Profile({
    this.name,
    this.email,
    this.id,
    this.picture,
  });

  final String? name;
  final String? picture;
  final email;
  final String? id;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"] == null ? null : json["name"],
        picture: json["picture"] == null ? null : json["picture"],
        email: json["email"] == null ? null : json["email"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "picture": picture == null ? null : picture,
        "email": email == null ? null : email,
        "id": id == null ? null : id,
      };
}
