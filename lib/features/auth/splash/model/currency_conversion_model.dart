class CurrencyConversionModel {
  CurrencyConversionModel({
    this.data,
  });

  final Data? data;

  factory CurrencyConversionModel.fromJson(Map<String, dynamic> json) =>
      CurrencyConversionModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currency,
    this.factor,
    this.round,
    this.config,
    this.nextCampaign,
    this.navBar,
    this.appOffer,
  });

  final String? currency;
  final double? factor;
  final int? round;
  final Config? config;
  final NextCampaign? nextCampaign;
  final List<NavBar>? navBar;
  final AppOffer? appOffer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currency: json["currency"] == null ? null : json["currency"],
        factor: json["factor"] == null ? null : json["factor"].toDouble(),
        round: json["round"] == null ? null : json["round"],
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
        nextCampaign: json["nextCampaign"] == null
            ? null
            : NextCampaign.fromJson(json["nextCampaign"]),
        navBar: json["navBar"] == null
            ? null
            : List<NavBar>.from(json["navBar"].map((x) => NavBar.fromJson(x))),
        appOffer: json["appOffer"] == null
            ? null
            : AppOffer.fromJson(json["appOffer"]),
      );
}

class Config {
  Config({
    this.lastDeliveryHour,
    this.minCartAmount,
    this.minCartMessage,
    this.giftCharge,
    this.deliverableDays,
    this.itemConditions,
    this.giftNote,
    this.icons,
  });

  final int? lastDeliveryHour;
  final int? minCartAmount;
  final dynamic minCartMessage;
  final int? giftCharge;
  final List<String>? deliverableDays;
  final ItemConditions? itemConditions;
  final String? giftNote;
  final NavIcons? icons;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        lastDeliveryHour:
            json["lastDeliveryHour"] == null ? null : json["lastDeliveryHour"],
        minCartAmount:
            json["minCartAmount"] == null ? null : json["minCartAmount"],
        minCartMessage: json["minCartMessage"],
        giftCharge: json["giftCharge"] == null ? null : json["giftCharge"],
        deliverableDays: json["deliverableDays"] == null
            ? null
            : List<String>.from(json["deliverableDays"].map((x) => x)),
        itemConditions: json["itemConditions"] == null
            ? null
            : ItemConditions.fromJson(json["itemConditions"]),
        giftNote: json["giftNote"] == null ? null : json["giftNote"],
        icons: json["icons"] == null ? null : NavIcons.fromJson(json["icons"]),
      );
}

class ItemConditions {
  ItemConditions({
    this.sealPack,
    this.newWithoutBox,
    this.fairlyUsed,
    this.overlyUsed,
    this.notWorking,
  });

  final String? sealPack;
  final String? newWithoutBox;
  final String? fairlyUsed;
  final String? overlyUsed;
  final String? notWorking;

  factory ItemConditions.fromJson(Map<String, dynamic> json) => ItemConditions(
        sealPack: json["seal_pack"] == null ? null : json["seal_pack"],
        newWithoutBox:
            json["new_without_box"] == null ? null : json["new_without_box"],
        fairlyUsed: json["fairly_used"] == null ? null : json["fairly_used"],
        overlyUsed: json["overly_used"] == null ? null : json["overly_used"],
        notWorking: json["not_working"] == null ? null : json["not_working"],
      );
}

class AppOffer {
  AppOffer({
    this.code,
    this.discount,
    this.platforms,
    this.footnote,
  });

  String? code;
  Discount? discount;
  List<String>? platforms;
  String? footnote;

  factory AppOffer.fromJson(Map<String, dynamic> json) => AppOffer(
        code: json["code"],
        discount: Discount.fromJson(json["discount"]),
        platforms: List<String>.from(json["platforms"].map((x) => x)),
        footnote: json["footnote"],
      );
}

class Discount {
  Discount({
    this.type,
    this.value,
  });

  String? type;
  int? value;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        type: json["type"],
        value: json["value"],
      );
}

class NavIcons {
  NavIcons({
    this.home,
    this.categories,
    this.contact,
    this.profile,
  });

  String? home;
  String? categories;
  String? contact;
  String? profile;

  factory NavIcons.fromJson(Map<String, dynamic> json) => NavIcons(
        home: json["home"],
        categories: json["categories"],
        contact: json["contact"],
        profile: json["profile"],
      );
}

class NavBar {
  NavBar({
    this.name,
    this.slug,
    this.type,
  });

  String? name;
  String? slug;
  String? type;

  factory NavBar.fromJson(Map<String, dynamic> json) => NavBar(
        name: json["name"],
        slug: json["slug"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "type": type,
      };
}

class NextCampaign {
  NextCampaign({
    this.name,
    this.icon,
    this.slug,
    this.starts,
    this.ends,
  });

  String? name;
  String? icon;
  String? slug;
  DateTime? starts;
  DateTime? ends;

  factory NextCampaign.fromJson(Map<String, dynamic> json) => NextCampaign(
        name: json["name"],
        icon: json["icon"],
        slug: json["slug"],
        starts: DateTime.parse(json["starts"]),
        ends: DateTime.parse(json["ends"]),
      );
}
