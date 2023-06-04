import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:classifields_apk_flutter/src/enviroments/enviroments.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:classifields_apk_flutter/src/services/storage_service.dart';
import 'package:classifields_apk_flutter/src/services/logging_interceptor.dart';

final env = Environments();

final client = LoggingInterceptor();

class SignInController {
  final storageService = StorageService();

  Future<dynamic> signIn({required String email, required String password}) async {
    try {
      Map<String, dynamic> body = {'email': email, 'password': password};

      http.Response response =
          await http.post(Uri.parse('${env.baseUrl}/user/login'), body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('${response.body}, return api');

        final user = UserModel.fromMap(jsonDecode(response.body));

        //Salvar o token
        bool saveSuccessful = await storageService.saveLocalObject(
            key: ConstantsApk.userLogado, data: user);

        if (saveSuccessful) {
          // O objeto foi salvo com sucesso
          print('Objeto salvo com sucessoooo!');

          //pegando os dados salvos no storage
          String? localData =
              await storageService.getLocalData(key: ConstantsApk.userLogado);

          if (localData != null) {
            UserModel user = UserModel.fromMap(jsonDecode(localData));

            // Imprime o objeto User logado
            print('Objeto User Logado: ${user.realName}');

            print('Objeto User Logado: ${user}');

            return true;
          }
        }
      } else {
        print('aconteceu um erro: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception('Error in create user');
    }
  }

  Future<dynamic> validateToken() async {
    try {
      String? token = '';      

      String? localData =
          await storageService.getLocalData(key: ConstantsApk.userLogado);

      if (localData != null) {
        UserModel user = UserModel.fromMap(jsonDecode(localData));

        token = user.token;
      }     

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };      

      http.Response response = await client.get(
          Uri.parse('${env.baseUrl}/user/token/validateToken'),
          headers: headers);          

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final validate = response.body;
        print('$validate , ok1');

        if (validate == 'true') {
          print('$validate , ok');
          return true;
        }
      } else {
        print('aconteceu um erro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e ,Error in create user');
    }
  }

  Future<dynamic> refreshToken() async {
    try {
      String? token = '';

      String? localData =
          await storageService.getLocalData(key: ConstantsApk.userLogado);

      if (localData != null) {
        UserModel user = UserModel.fromMap(jsonDecode(localData));

        token = user.token;
      }

      Map<String, dynamic> body = {'oldToken': token};

      await logout();      

      http.Response response = await http
          .post(Uri.parse('${env.baseUrl}/token/refreshToken'), body: body);

      print('${response.statusCode} controller');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('${response.body}, return refresh token');

        final user = UserModel.fromMap(jsonDecode(response.body));

        //Salvar o token
        bool saveSuccessful = await storageService.saveLocalObject(
            key: ConstantsApk.userLogado, data: user);

        if (saveSuccessful) {
          // O objeto foi salvo com sucesso
          print('Objeto salvo com sucessoooo! refresh token');

          // Imprime o objeto User logado
          print('Objeto User Logado: ${user.token}, refresh');

          print('Objeto User Logado: ${user}, refresh');

          String? localData =
              await storageService.getLocalData(key: ConstantsApk.userLogado);

          if (localData != null) {
            UserModel user = UserModel.fromMap(jsonDecode(localData));

            return user.token;
          }
        }
      } else {
        print('aconteceu um erro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in create user');
    }
  }

  Future<dynamic> logout() async {
    try {
      storageService.removeLocalData(key: ConstantsApk.userLogado);

      return true;
    } catch (err) {
      throw Exception('$err ,Error in create user');
    }
  }
}
