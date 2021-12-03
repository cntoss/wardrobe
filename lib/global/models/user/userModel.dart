class UserModel {
  UserModel({
    this.data,
    this.message,
  });

  final UserModelData? data;
  final String? message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data:
            json["data"] == null ? null : UserModelData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class UserModelData {
  UserModelData({
    this.uuid,
    this.name,
    this.username,
    this.profileImage,
    this.coverImage,
    this.bio,
    this.email,
    this.countryCode,
    this.phoneNumber,
    this.gender,
    this.dob,
    this.isReferred,
    this.social,
    this.settings,
    this.creditAmount,
    this.customerClass,
    this.role,
    this.phoneVerified,
    this.emailVerified,
    this.verified,
    this.notifications,
    this.connections,
    this.businesses,
    this.totalOrders,
    this.views,
    this.totalCartItems,
    this.totalAddress,
    this.totalWishlist,
    this.totalConnectionRequests,
    this.token,
  });

  final String? uuid;
  final String? name;
  final String? username;
  final String? profileImage;
  final dynamic coverImage;
  final dynamic bio;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? gender;
  final DateTime? dob;
  final UserSocial? social;
  final Settings? settings;
  final int? creditAmount;
  final dynamic customerClass;
  final String? role;
  final bool? phoneVerified;
  final bool? emailVerified;
  final bool? verified;
  final bool? isReferred;
  final List<dynamic>? notifications;
  final List<UserConnection>? connections;
  final List<dynamic>? businesses;
  final int? totalOrders;
  final int? views;
  final int? totalCartItems;
  final int? totalAddress;
  final int? totalWishlist;
  final int? totalConnectionRequests;
  final String? token;

  factory UserModelData.fromJson(Map<String, dynamic> json) => UserModelData(
        uuid: json["uuid"] == null ? null : json["uuid"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        profileImage:
            json["profileImage"] == null ? null : json["profileImage"],
        coverImage: json["coverImage"],
        bio: json["bio"],
        email: json["email"] == null ? null : json["email"],
        countryCode:
            json["countryCode"] == null ? null : json["countryCode"].toString(),
        phoneNumber:
            json["phoneNumber"] == null ? null : json["phoneNumber"].toString(),
        gender: json["gender"] == null ? null : json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        isReferred: json["isReferred"] == null ? null : json["isReferred"],
        social:
            json["social"] == null ? null : UserSocial.fromJson(json["social"]),
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
        creditAmount:
            json["creditAmount"] == null ? null : json["creditAmount"],
        customerClass: json["customerClass"],
        role: json["role"] == null ? null : json["role"],
        phoneVerified:
            json["phoneVerified"] == null ? null : json["phoneVerified"],
        emailVerified:
            json["emailVerified"] == null ? null : json["emailVerified"],
        verified: json["verified"] == null ? null : json["verified"],
        notifications: json["notifications"] == null
            ? null
            : List<dynamic>.from(json["notifications"].map((x) => x)),
        connections: json["connections"] == null
            ? null
            : List<UserConnection>.from(
                json["connections"].map((x) => UserConnection.fromJson(x))),
        businesses: json["businesses"] == null
            ? null
            : List<dynamic>.from(json["businesses"].map((x) => x)),
        totalOrders: json["totalOrders"] == null ? null : json["totalOrders"],
        views: json["views"] == null ? null : json["views"],
        totalCartItems:
            json["totalCartItems"] == null ? null : json["totalCartItems"],
        totalAddress:
            json["totalAddress"] == null ? null : json["totalAddress"],
        totalWishlist:
            json["totalWishlist"] == null ? null : json["totalWishlist"],
        totalConnectionRequests: json["totalConnectionRequests"] == null
            ? null
            : json["totalConnectionRequests"],
        token: json["token"] == null ? null : json["token"],
      );
}

class Settings {
  Settings({
    this.privacy,
    this.notification,
  });

  final Privacy? privacy;
  final Notification? notification;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        privacy:
            json["privacy"] == null ? null : Privacy.fromJson(json["privacy"]),
        notification: json["notification"] == null
            ? null
            : Notification.fromJson(json["notification"]),
      );

  Map<String, dynamic> toJson() => {
        "privacy": privacy == null ? null : privacy!.toJson(),
        "notification": notification == null ? null : notification!.toJson(),
      };
}

class Notification {
  Notification({
    this.orderProcessed,
    this.orderReady,
    this.orderAssigned,
    this.orderCompleted,
  });

  final bool? orderProcessed;
  final bool? orderReady;
  final bool? orderAssigned;
  final bool? orderCompleted;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        orderProcessed:
            json["orderProcessed"] == null ? null : json["orderProcessed"],
        orderReady: json["orderReady"] == null ? null : json["orderReady"],
        orderAssigned:
            json["orderAssigned"] == null ? null : json["orderAssigned"],
        orderCompleted:
            json["orderCompleted"] == null ? null : json["orderCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "orderProcessed": orderProcessed == null ? null : orderProcessed,
        "orderReady": orderReady == null ? null : orderReady,
        "orderAssigned": orderAssigned == null ? null : orderAssigned,
        "orderCompleted": orderCompleted == null ? null : orderCompleted,
      };
}

class Privacy {
  Privacy({
    this.showBirthday,
    this.showBio,
    this.showSocial,
  });

  final bool? showBirthday;
  final bool? showBio;
  final bool? showSocial;

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
        showBirthday:
            json["showBirthday"] == null ? null : json["showBirthday"],
        showBio: json["showBio"] == null ? null : json["showBio"],
        showSocial: json["showSocial"] == null ? null : json["showSocial"],
      );

  Map<String, dynamic> toJson() => {
        "showBirthday": showBirthday == null ? null : showBirthday,
        "showBio": showBio == null ? null : showBio,
        "showSocial": showSocial == null ? null : showSocial,
      };
}

class UserConnection {
  UserConnection({
    this.name,
    this.username,
    this.image,
  });

  final String? name;
  final String? username;
  final String? image;

  factory UserConnection.fromJson(Map<String, dynamic> json) => UserConnection(
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        image: json["image"] == null ? null : json["image"],
      );
}

class UserSocial {
  UserSocial({
    this.facebook,
    this.instagram,
    this.tiktok,
    this.linkedin,
    this.website,
  });

  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? linkedin;
  final String? website;

  factory UserSocial.fromJson(Map<String, dynamic> json) => UserSocial(
        facebook: json["facebook"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
        linkedin: json["linkedin"],
        website: json["website"],
      );
}
