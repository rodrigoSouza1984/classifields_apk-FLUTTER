import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';

class UserControllerGetx extends GetxController {
  List<UserModel> users = [];
  int total = 0;
  UserController userController = UserController();

  Future<void> getAllUsers(int currentPage, int take) async {
    try {
      final value = await userController.getUsers(page: currentPage, take: take);
      users.addAll(value['users']);
      total = value['total'];     
      update(); // Utilize o método update() para notificar os ouvintes
    } catch (error) {
      // Trate o erro conforme necessário
      print('Ocorreu um erro ao buscar os usuários: $error');
    }
  }

  Future<void> getUsersByUserNameLikeFilter(String userName) async {
    try {
      if (userName == '') {
        return;
      }

      final value = await userController.getUsersByUserNameLikeFilter(userName);

      if (value['users'].length > 0) {
        clearUsers();
      }

      users.addAll(value['users']);
      total = value['total'];

      update(); // Utilize o método update() para notificar os ouvintes

    } catch (error) {
      // Trate o erro conforme necessário
      print('Ocorreu um erro ao buscar os usuários: $error, method: user_provider.dart getUsersByUserNameLikeFilter');
    }
  }

  void updateUsers(List<UserModel> newUsers) {
    users.addAll(newUsers);
    update(); // Utilize o método update() para notificar os ouvintes
  }

  void removeUser(UserModel user) {
    users.remove(user);
    total--;
    update(); // Utilize o método update() para notificar os ouvintes
  }

  void clearUsers() {
    users.clear();
    total = 0;
    update(); // Utilize o método update() para notificar os ouvintes
  }
}