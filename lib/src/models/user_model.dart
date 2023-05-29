import 'package:classifields_apk_flutter/src/models/user_media_avatar_model.dart';

class UserModel {
  int? id;
  String? realName;
  String? userName;
  String? email;
  String? dateOfBirth;  
  String? token;
  UserMediaAvatarModel? mediaAvatar; 

  UserModel({
    this.id,
    this.realName,
    this.userName,
    this.email,
    this.dateOfBirth,
    this.token,
    this.mediaAvatar
  });   

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user']['id'],
      realName: map['user']['realName'],
      userName: map['user']['userName'],
      email: map['user']['email'],
      dateOfBirth: map['user']['dateOfBirth'],
      token: map['access_token'],
      mediaAvatar: UserMediaAvatarModel.fromMap(map['user']['mediaAvatar']),
    );
  }

  Map<String, dynamic> toMap() {//converte um objeto em um map
    return {
      'id': id,
      'realName': realName,
      'userName': userName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'token': token,
      'mediaAvatar': mediaAvatar?.toMap(),
    };
  }

  Map<String, dynamic> toJson() {//converte um objeto em um JSON
    return {
      'user': {
        'id': id,
        'realName': realName,
        'userName': userName,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'mediaAvatar': mediaAvatar?.toJson(),
      },
      'access_token': token,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      realName: json['realName'],
      userName: json['userName'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      token: json['token'],
      mediaAvatar: json['mediaAvatar'] != null
          ? UserMediaAvatarModel.fromJson(json['mediaAvatar'])
          : null,
    );
  }

  @override
  String toString() {
    return 'user: { id: $id, realName: $realName, userName: $userName, email: $email, dataOfBirth: $dateOfBirth, $mediaAvatar}, token: $token';
  }
}