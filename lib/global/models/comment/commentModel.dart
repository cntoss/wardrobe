class CommentModel {
  CommentModel({
    this.meta,
    this.data,
  });

  final Meta? meta;
  final List<Comment>? data;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta == null ? null : meta!.toJson(),
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.created,
    this.id,
    this.user,
    this.parent,
    this.body,
    this.tags,
    this.children,
    this.reaction,
  });

  final DateTime? created;
  final int? id;
  final User? user;
  final dynamic parent;
  final String? body;
  final List<dynamic>? tags;
  final int? children;
  final Reaction? reaction;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"] == null ? null : json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        parent: json["parent"],
        body: json["body"] == null ? null : json["body"],
        tags: json["tags"] == null
            ? null
            : List<dynamic>.from(json["tags"].map((x) => x)),
        children: json["children"] == null ? null : json["children"],
        reaction: json["reaction"] == null
            ? null
            : Reaction.fromJson(json["reaction"]),
      );

  Map<String, dynamic> toJson() => {
        "created": created == null ? null : created!.toIso8601String(),
        "id": id == null ? null : id,
        "user": user == null ? null : user!.toJson(),
        "parent": parent,
        "body": body == null ? null : body,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "children": children == null ? null : children,
        "reaction": reaction == null ? null : reaction!.toJson(),
      };
}

class Reaction {
  Reaction({
    this.previous,
    this.likeCount,
    this.dislikeCount,
  });

  final int? previous;
  final int? likeCount;
  final int? dislikeCount;

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        previous: json["previous"] == null ? null : json["previous"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        dislikeCount:
            json["dislikeCount"] == null ? null : json["dislikeCount"],
      );

  Map<String, dynamic> toJson() => {
        "previous": previous == null ? null : previous,
        "likeCount": likeCount == null ? null : likeCount,
        "dislikeCount": dislikeCount == null ? null : dislikeCount,
      };
}

class User {
  User({
    this.uuid,
    this.name,
    this.username,
    this.avatar,
    this.active,
  });

  final String? uuid;
  final String? name;
  final String? username;
  final String? avatar;
  final bool? active;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uuid: json["uuid"] == null ? null : json["uuid"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid == null ? null : uuid,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "avatar": avatar == null ? null : avatar,
        "active": active == null ? null : active,
      };
}

class Meta {
  Meta({
    this.pagination,
  });

  final Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination == null ? null : pagination!.toJson(),
      };
}

class Pagination {
  Pagination({
    this.lastPage,
    this.perPage,
    this.total,
  });

  final int? lastPage;
  final int? perPage;
  final int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        lastPage: json["lastPage"] == null ? null : json["lastPage"],
        perPage: json["perPage"] == null ? null : json["perPage"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "lastPage": lastPage == null ? null : lastPage,
        "perPage": perPage == null ? null : perPage,
        "total": total == null ? null : total,
      };
}
