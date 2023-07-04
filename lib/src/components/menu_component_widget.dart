import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';

class MenuItem {
  final String name;
  final IconData icon;

  MenuItem({required this.name, required this.icon});
}

class MenuComponentWidget extends StatefulWidget {
  final Function(String) onItemSelected;
  final String pageCallThisComponent;

  const MenuComponentWidget(
      {required this.onItemSelected, required this.pageCallThisComponent});

  @override
  _MenuComponentWidgetState createState() => _MenuComponentWidgetState();
}

class _MenuComponentWidgetState extends State<MenuComponentWidget> {
  final ValueNotifier<String?> _selectedValue = ValueNotifier<String?>(null);
  final SignInController authController = SignInController();
  final UserController userController = UserController();
  UserModel user = UserModel();

  List<MenuItem> listFullItems = [
    MenuItem(name: 'Dados Cadastrais', icon: Icons.perm_identity),
    MenuItem(name: 'Usuários Cadastrados', icon: Icons.perm_identity),
    MenuItem(name: 'Trocar Senha', icon: Icons.lock),
    MenuItem(name: 'Logout', icon: Icons.logout),
  ];

  List<MenuItem> listWithFilterShowMenu = [];

  @override
  initState() {
    super.initState();

    getLocalUser();
  }

  getLocalUser() async {
    final userLocal = await userController.userLocalData();

    if (userLocal != null) {
      await userController.getUserById(userLocal.id).then((value) async => {
            setState(() {
              user = value;
            }),
            if (user.userName != null)
              {
                addItemsFilteredsToList(),
              },
          });
    } else {
      print('erro aki karalho $userLocal');
    }
  }

  void addItemsFilteredsToList() {
    listWithFilterShowMenu.add(listFullItems[
        listFullItems.indexWhere((item) => item.name == 'Dados Cadastrais')]);

    if (user.typePermissionEnum == 'admin') {
      //filtrando a lista pela consdicao inventada para exemplo
      listWithFilterShowMenu.add(listFullItems[listFullItems
          .indexWhere((item) => item.name == 'Usuários Cadastrados')]);
    }

    listWithFilterShowMenu.add(listFullItems[
        listFullItems.indexWhere((item) => item.name == 'Trocar Senha')]);

    listWithFilterShowMenu.add(listFullItems[
        listFullItems.indexWhere((item) => item.name == 'Logout')]);

    List<String> values = //convertendo para poder printar
        listWithFilterShowMenu.map((item) => item.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Defina a largura desejada para o Drawer
      child: Drawer(
        backgroundColor: Colors.white.withAlpha(230),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0,
                  left: 10,
                  right:
                      16), //EdgeInsets.symmetric(horizontal: 16), // ajusta a posicao lateral dos itens
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listWithFilterShowMenu.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(listWithFilterShowMenu[index].name),
                    leading: Icon(listWithFilterShowMenu[index].icon),
                    onTap: () {
                      Navigator.pop(context); // Fechar o menu após a seleção
                      _handleItemSelected(listWithFilterShowMenu[index].name);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemSelected(String value) async {
    try {
      _selectedValue.value = value;

      if (value == 'Logout') {
        authController
            .logout()
            .then((value) => NavigationService.pushNamed('/login'));
      } else if (value == 'Dados Cadastrais') {
        Map<String, dynamic> arguments = {
          'user': user,
          'updatePassword': false,
        };

        NavigationService.pushNamed('/register', arguments: arguments);
      } else if (value == 'Usuários Cadastrados') {
        print('Item 2 clicado');
      } else if (value == 'Trocar Senha') {
        Map<String, dynamic> arguments = {
          'user': user,
          'updatePassword': true,
        };
        
        NavigationService.pushNamed('/register', arguments: arguments);
      }
      widget.onItemSelected(value);
    } catch (e) {
      print('teste erro aki , $e');
    }
  }

  @override
  void dispose() {
    _selectedValue.dispose();
    super.dispose();
  }
}
