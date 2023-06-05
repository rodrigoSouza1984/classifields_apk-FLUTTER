import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:classifields_apk_flutter/src/enviroments/enviroments.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:classifields_apk_flutter/src/services/storage_service.dart';
import 'package:classifields_apk_flutter/src/services/logging_interceptor.dart';

class UserController {
  
  final env = Environments();

  final client = LoggingInterceptor();

  final storageService = StorageService();

  Future<dynamic> createUserNameUnique(String userName) async {
    try {
      
      if(userName == '' || userName == null){
        return;
      }

      http.Response response = await client.get(
        Uri.parse('${env.baseUrl}/user/createUserNameUnique/$userName'),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final validate = jsonDecode(response.body);
        return validate;
      } else {
        print('aconteceu um erro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e ,Error in create user');
    }
  }
}
