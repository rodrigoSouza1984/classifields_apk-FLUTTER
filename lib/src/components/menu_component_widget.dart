import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';

import 'package:classifields_apk_flutter/src/services/storage_service.dart';
import 'package:classifields_apk_flutter/src/enviroments/enviroments.dart';
import 'dart:convert';

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

  final storageService = StorageService();
  UserModel user = UserModel();
  String? localDataReturned = '';
  dynamic localData;
  UserModel userLocal = UserModel();
  UserModel userLocalDataVar = UserModel();

  List<MenuItem> listFullItems = [
    MenuItem(name: 'Dados Cadastrais', icon: Icons.perm_identity),
    MenuItem(name: 'Usuários Cadastrados', icon: Icons.perm_identity),
    MenuItem(name: 'Item 3', icon: Icons.access_time),
    MenuItem(name: 'Logout', icon: Icons.logout),
  ];

  List<MenuItem> listWithFilterShowMenu = [];

  @override
  void initState() {
    super.initState();

    userLocalData().then((v) {
      userController.getUserById(userLocalDataVar.id).then((value) async => {
            setState(() {
              user = value;
            }),
            if (user.userName != null)
              {
                addItemsFilteredsToList(),
              },
          });
    });
  }

  userLocalData() async {
    localDataReturned =
        await storageService.getLocalData(key: ConstantsApk.userLogado);
    localData = jsonDecode(localDataReturned!);
    if (localData != null) {
      userLocal = UserModel.fromMap(localData['user']);
      setState(() {
        userLocalDataVar = userLocal;
      });
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
        listFullItems.indexWhere((item) => item.name == 'Item 3')]);

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
                      _handleItemSelected(listWithFilterShowMenu[index].name);
                      Navigator.pop(context); // Fechar o menu após a seleção
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
    _selectedValue.value = value;
    if (value == 'Logout') {
      authController.logout().then((value) {
        print('$value, logout');
        Navigator.of(context).pop();
      });
    } else if (value == 'Dados Cadastrais') {
      print('Dados Cadastrais clicado');
      //await userController.getUserById();
    } else if (value == 'Usuários Cadastrados') {
      print('Item 2 clicado');
    } else if (value == 'Item 3') {
      print('Item 3 clicado');
    }
    widget.onItemSelected(value);
  }

  @override
  void dispose() {
    _selectedValue.dispose();
    super.dispose();
  }
}
