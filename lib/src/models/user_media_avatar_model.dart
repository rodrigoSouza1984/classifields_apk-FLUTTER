class UserMediaAvatarModel {
  int? id;
  String? name;
  String? mimeType;
  String? url;
  String? base64;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserMediaAvatarModel({
    this.id,
    this.name,
    this.mimeType,
    this.url,
    this.base64,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserMediaAvatarModel.fromMap(Map<String, dynamic> map) {
    return UserMediaAvatarModel(
      id: map['id'],
      name: map['name'],
      mimeType: map['mimeType'],
      url: map['url'],
      base64: map['base64'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mimeType': mimeType,
      'url': url,
      'base64': base64,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mimeType': mimeType,
      'url': url,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'base64': base64
    };
  }

  factory UserMediaAvatarModel.fromJson(Map<String, dynamic> json) {
    return UserMediaAvatarModel(
      id: json['id'],
      name: json['name'],
      mimeType: json['mimeType'],
      url: json['url'],
      base64: json['base64'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }

  @override
  String toString() {
    //return 'avatar: $url';
    return 'mediaAvatar: { id: $id, name: $name, mimeType: $mimeType, url: $url, base64: $base64, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt }';
  }
}
