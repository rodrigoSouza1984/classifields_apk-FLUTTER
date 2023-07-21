import 'package:flutter/foundation.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];
  int total = 0;
  UserController userController = UserController();

  Future<void> getAllUsers(int currentPage, int take) async {
    try {
      final value = await userController.getUsers(page: currentPage, take: take);      
      users.addAll(value['users']);
      total = value['total'];      
      notifyListeners();
    } catch (error) {
      // Trate o erro conforme necessário
      print('Ocorreu um erro ao buscar os usuários: $error');
    }
  }

  

  Future<void> getUsersByUserNameLikeFilter(String userName) async {
    try {

      if(userName == ''){
        return;
      }    

      final value = await userController.getUsersByUserNameLikeFilter(userName);      
      
      if(value['users'].length > 0){
        clearUsers();
      }

      users.addAll(value['users']);
      
      total = value['total']; 

      

      notifyListeners();

    } catch (error) {
      // Trate o erro conforme necessário
      print('Ocorreu um erro ao buscar os usuários: $error, method: user_provider.dart getUsersByUserNameLikeFilter');
    }
  }

  void updateUsers(List<UserModel> newUsers) {
    users.addAll(newUsers);
    notifyListeners();
  }

  void removeUser(UserModel user) {
    users.remove(user);
    total--;
    notifyListeners(); // Notificar os ouvintes após a exclusão
  }

  void clearUsers() {
    users.clear();
    total = 0;
    notifyListeners();
  }

  
}
