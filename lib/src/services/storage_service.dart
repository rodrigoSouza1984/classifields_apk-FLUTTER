
import 'package:shared_preferences/shared_preferences.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'dart:convert';

class StorageService {
  // Salva dados localmente
  Future<void> saveLocalData(
      {required String key, required String data}) async {                      //=> esse aki para salvar caso seja um valor tipo token : 'aalsalslakjslkajs'
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

// Salva objeto localmente
  Future<bool> saveLocalObject(
      {required String key, required UserModel data}) async {                  //=> salvando o obejoto esse que usamos para salvar o user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userLogadoJson =
        jsonEncode(data.toJson());                                             //=> converter toJson la do model
    return await prefs.setString(key, userLogadoJson);
  }

// Recupera dados salvos localmente
  Future<String?> getLocalData({required String key}) async {                 //=> RECUPERA O DADOS ESPECIFICO PELO NOME DA CHAVE NO STORAGE
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

// Remove dados salvos localmente
  Future<void> removeLocalData({required String key}) async {                 //=> => REMOVE PELO NOME DA CHAVE
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}