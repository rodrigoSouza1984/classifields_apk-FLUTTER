import 'package:classifields_apk_flutter/src/models/user_media_avatar_model.dart';

class UserModel {
  int? id;
  String? realName;
  String? userName;
  String? email;
  String? dateOfBirth;
  String? token;
  String? typePermissionEnum;
  UserMediaAvatarModel? mediaAvatar;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserModel(
      {this.id,
      this.realName,
      this.userName,
      this.email,
      this.dateOfBirth,
      this.typePermissionEnum,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.token,
      this.mediaAvatar});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        id: map['id'],
        realName: map['realName'],
        userName: map['userName'],
        email: map['email'],
        dateOfBirth: map['dateOfBirth'] ?? 'N/A',
        typePermissionEnum: map['typePermissionEnum'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        deletedAt: map['deletedAt'],
        token: map['token'],
        mediaAvatar:
            map.containsKey('mediaAvatar') && map['mediaAvatar'] != null
                ? UserMediaAvatarModel.fromMap(map['mediaAvatar'])
                : null,
      );
    } catch (e) {
      print('Erro ao criar UserModel a partir do mapa: $e');
      throw Exception('Erro ao criar UserModel a partir do mapa');
    }
  }  

  Map<String, dynamic> toMap() {
    //converte um objeto em um map
    return {
      'id': id,
      'realName': realName,
      'userName': userName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'typePermissionEnum': typePermissionEnum,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'token': token,
      'mediaAvatar': mediaAvatar?.toMap(),
    };
  }

  Map<String, dynamic> toJson() {
    //converte um objeto em um JSON    
    try{
    return {
      'user': {
        'id': id,
        'realName': realName,
        'userName': userName,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'typePermissionEnum': typePermissionEnum,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'mediaAvatar': mediaAvatar?.toJson(),
        'token': token,
      },      
    };
    } catch (e) {
      print('Erro ao criar UserModel a partir do mapa: $e');
      throw Exception('Erro ao criar UserModel a partir do mapa');
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      realName: json['realName'],
      userName: json['userName'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      typePermissionEnum: json['typePermissionEnum'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      token: json['token'],
      mediaAvatar: json['mediaAvatar'] != null
          ? UserMediaAvatarModel.fromJson(json['mediaAvatar'])
          : null,
    );
  }

  @override
  String toString() {
    return '{ id: $id, realName: $realName, userName: $userName, email: $email, dataOfBirth: $dateOfBirth, typePermissionEnum: $typePermissionEnum createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, $mediaAvatar, token: $token}';
  }
}
