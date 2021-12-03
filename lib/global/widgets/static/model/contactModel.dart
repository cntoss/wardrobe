class ContactModel {
  ContactModel({
    this.meta,
    this.data,
    this.message,
  });

  final Meta? meta;
  final Data? data;
  final String? message;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "meta": meta!.toJson(),
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.banner,
    this.content,
  });

  final Banner? banner;
  final Content? content;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banner: Banner.fromJson(json["banner"]),
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "banner": banner!.toJson(),
        "content": content!.toJson(),
      };
}

class Banner {
  Banner({
    this.backgroundColor,
    this.textColor,
    this.backgroundImage,
    this.backgroundImageMobile,
    this.title,
    this.subtitle,
  });

  final String? backgroundColor;
  final String? textColor;
  final String? backgroundImage;
  final String? backgroundImageMobile;
  final String? title;
  final String? subtitle;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        backgroundColor: json["backgroundColor"],
        textColor: json["textColor"],
        backgroundImage: json["backgroundImage"],
        backgroundImageMobile: json["backgroundImageMobile"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String?, dynamic> toJson() => {
        "backgroundColor": backgroundColor,
        "textColor": textColor,
        "backgroundImage": backgroundImage,
        "backgroundImageMobile": backgroundImageMobile,
        "title": title,
        "subtitle": subtitle,
      };
}

class Content {
  Content({
    this.newsletter,
    this.navLinks,
    this.socialMediaHeader,
    this.socialMedia,
    this.playstore,
    this.appstore,
    this.appHeader,
    this.locations,
    this.phone,
    this.email,
  });

  final Newsletter? newsletter;
  final List<NavLink>? navLinks;
  final SocialMediaHeader? socialMediaHeader;
  final List<SocialMedia>? socialMedia;
  final String? playstore;
  final String? appstore;
  final AppHeader? appHeader;
  final List<Location>? locations;
  final List<Email>? phone;
  final List<Email>? email;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        newsletter: Newsletter.fromJson(json["newsletter"]),
        navLinks: List<NavLink>.from(
            json["navLinks"].map((x) => NavLink.fromJson(x))),
        socialMediaHeader:
            SocialMediaHeader.fromJson(json["socialMediaHeader"]),
        socialMedia: List<SocialMedia>.from(
            json["socialMedia"].map((x) => SocialMedia.fromJson(x))),
        playstore: json["playstore"],
        appstore: json["appstore"],
        appHeader: AppHeader.fromJson(json["appHeader"]),
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        phone: List<Email>.from(json["phone"].map((x) => Email.fromJson(x))),
        email: List<Email>.from(json["email"].map((x) => Email.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "newsletter": newsletter!.toJson(),
        "navLinks": List<dynamic>.from(navLinks!.map((x) => x.toJson())),
        "socialMediaHeader": socialMediaHeader!.toJson(),
        "socialMedia": List<dynamic>.from(socialMedia!.map((x) => x.toJson())),
        "playstore": playstore,
        "appstore": appstore,
        "appHeader": appHeader!.toJson(),
        "locations": List<dynamic>.from(locations!.map((x) => x.toJson())),
        "phone": List<dynamic>.from(phone!.map((x) => x.toJson())),
        "email": List<dynamic>.from(email!.map((x) => x.toJson())),
      };
}

class AppHeader {
  AppHeader({
    this.title,
    this.subtitle,
    this.buttonText,
    this.buttonUrl,
  });

  final String? title;
  final String? subtitle;
  final String? buttonText;
  final String? buttonUrl;

  factory AppHeader.fromJson(Map<String, dynamic> json) => AppHeader(
        title: json["title"],
        subtitle: json["subtitle"],
        buttonText: json["buttonText"],
        buttonUrl: json["buttonUrl"],
      );

  Map<String?, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "buttonText": buttonText,
        "buttonUrl": buttonUrl,
      };
}

class Email {
  Email({
    this.type,
    this.value,
  });

  final String? type;
  final String? value;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        type: json["type"],
        value: json["value"],
      );

  Map<String?, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class Location {
  Location({
    this.id,
    this.name,
    this.location,
    this.phone,
    this.email,
    this.lat,
    this.long,
    this.identifier,
    this.banner,
  });

  final int? id;
  final String? name;
  final String? location;
  final String? phone;
  final String? email;
  final String? lat;
  final String? long;
  final String? identifier;
  final Banner? banner;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        phone: json["phone"],
        email: json["email"],
        lat: json["lat"],
        long: json["long"],
        identifier: json["identifier"],
        banner: Banner.fromJson(json["banner"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "phone": phone,
        "email": email,
        "lat": lat,
        "long": long,
        "identifier": identifier,
        "banner": banner!.toJson(),
      };
}

class NavLink {
  NavLink({
    this.title,
    this.items,
  });

  final String? title;
  final List<Item>? items;

  factory NavLink.fromJson(Map<String, dynamic> json) => NavLink(
        title: json["title"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.title,
    this.link,
  });

  final String? title;
  final String? link;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
      };
}

class Newsletter {
  Newsletter({
    this.buttonText,
    this.placeholder,
    this.image,
    this.imageMobile,
  });

  final String? buttonText;
  final String? placeholder;
  final String? image;
  final String? imageMobile;

  factory Newsletter.fromJson(Map<String, dynamic> json) => Newsletter(
        buttonText: json["buttonText"],
        placeholder: json["placeholder"],
        image: json["image"],
        imageMobile: json["imageMobile"],
      );

  Map<String, dynamic> toJson() => {
        "buttonText": buttonText,
        "placeholder": placeholder,
        "image": image,
        "imageMobile": imageMobile,
      };
}

class SocialMedia {
  SocialMedia({
    this.name,
    this.link,
  });

  final String? name;
  final String? link;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
      };
}

class SocialMediaHeader {
  SocialMediaHeader({
    this.title,
  });

  final String? title;

  factory SocialMediaHeader.fromJson(Map<String, dynamic> json) =>
      SocialMediaHeader(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class Meta {
  Meta({
    this.title,
    this.keywords,
    this.description,
    this.image,
  });

  final String? title;
  final String? keywords;
  final String? description;
  final String? image;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        title: json["title"],
        keywords: json["keywords"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "keywords": keywords,
        "description": description,
        "image": image,
      };
}
