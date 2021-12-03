class WishAndCartModel {
  WishAndCartModel({
    this.data,
    this.message,
  });

  final Data? data;
  final String? message;

  factory WishAndCartModel.fromJson(Map<String, dynamic> json) =>
      WishAndCartModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.wishlist,
    this.cart,
  });

  final Wishlist? wishlist;
  final Cart? cart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wishlist: json["wishlist"] == null
            ? null
            : Wishlist.fromJson(json["wishlist"]),
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "wishlist": wishlist == null ? null : wishlist!.toJson(),
        "cart": cart == null ? null : cart!.toJson(),
      };
}

class Cart {
  Cart({
    this.product,
  });

  final List<Product>? product;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        product: json["product"] == null
            ? null
            : List<Product>.from(
                json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product == null
            ? null
            : List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.cartItemId,
    this.name,
    this.slug,
    this.quantity,
    this.image,
    this.sale,
  });

  final int? id;
  final int? cartItemId;
  final String? name;
  final String? slug;
  final int? quantity;
  final Image? image;
  final Sale? sale;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        cartItemId: json["cartItemId"] == null ? null : json["cartItemId"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        sale: json["sale"] == null ? null : Sale.fromJson(json["sale"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cartItemId": cartItemId == null ? null : cartItemId,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "quantity": quantity == null ? null : quantity,
        "image": image == null ? null : image!.toJson(),
        "sale": sale == null ? null : sale!.toJson(),
      };
}

class Image {
  Image({
    this.path,
    this.file,
  });

  final String? path;
  final dynamic file;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json["path"] == null ? null : json["path"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "path": path == null ? null : path,
        "file": file,
      };
}

class Sale {
  Sale({
    this.status,
    this.mrp,
    this.price,
    this.off,
    this.tag,
    this.ends,
    this.unit,
  });

  final bool? status;
  final double? mrp;
  final double? price;
  final int? off;
  final String? tag;
  final String? ends;
  final String? unit;

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        status: json["status"] == null ? null : json["status"],
        mrp: json["mrp"] == null ? null : json["mrp"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        off: json["off"] == null ? null : json["off"],
        tag: json["tag"] == null ? null : json["tag"],
        ends: json["ends"] == null ? null : json["ends"],
        unit: json["unit"] == null ? null : json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "mrp": mrp == null ? null : mrp,
        "price": price == null ? null : price,
        "off": off == null ? null : off,
        "tag": tag == null ? null : tag,
        "ends": ends == null ? null : ends,
        "unit": unit == null ? null : unit,
      };
}

class Wishlist {
  Wishlist({
    this.product,
    this.automobile,
  });

  final List<int>? product;
  final List<dynamic>? automobile;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        product: json["product"] == null
            ? null
            : List<int>.from(json["product"].map((x) => x)),
        automobile: json["automobile"] == null
            ? null
            : List<dynamic>.from(json["automobile"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product":
          product == null ? null : List<dynamic>.from(product!.map((x) => x)),
        "automobile": automobile == null
            ? null
            : List<dynamic>.from(automobile!.map((x) => x)),
      };
}
