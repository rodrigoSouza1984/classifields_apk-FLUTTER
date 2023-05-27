
class UserMediaAvatarModel {
  int? id;
  String? name;
  String? mimeType;
  String? url;

  UserMediaAvatarModel({
    this.id,
    this.name,
    this.mimeType,
    this.url,    
  }); 

  factory UserMediaAvatarModel.fromMap(Map<String, dynamic> map){
    return UserMediaAvatarModel(
      id: map['id'],
      name: map['name'],
      mimeType: map['mimeType'],
      url: map['url'],      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mimeType': mimeType,
      'url': url,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mimeType': mimeType,
      'url': url,
    };
  }

  factory UserMediaAvatarModel.fromJson(Map<String, dynamic> json) {
    return UserMediaAvatarModel(
      id: json['id'],
      name: json['name'],
      mimeType: json['mimeType'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    //return 'avatar: $url';
    return 'mediaAvatar: { id: $id, name: $name, mimeType: $mimeType, url: $url }';
  }
}