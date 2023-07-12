import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';

class UserListPage extends StatefulWidget {
  UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool editOrDeleteUsers = false;

  final UserController userController = UserController();

  final ScrollController _scrollController = ScrollController();

  List<UserModel> users = [];
  int currentPage = 1;
  int take = 7;
  int total = 0;

  @override
  initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    getAllUsers();
  }

  getAllUsers() async {
    await userController
        .getUsers(page: currentPage, take: take)
        .then((value) async => {
              setState(() {
                users.addAll(value['users']);
                total = value['total'];
              })
            });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      currentPage++; // Incrementa a página atual
      getAllUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Lista de Usuários'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.edit,
                  size: 20.0,
                  color: editOrDeleteUsers ? Colors.blue : Colors.white),
              onPressed: () {
                setState(() {
                  editOrDeleteUsers = !editOrDeleteUsers;
                });
                // Ação quando o ícone de edição na AppBar for pressionado
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: users.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  leading: CircleAvatar(
                    backgroundImage: user.mediaAvatar != null
                        ? NetworkImage(user.mediaAvatar!.url!)
                        : const Image(
                            image: AssetImage('assets/images/avatarzinho.jpg'),
                          ).image as ImageProvider<Object>?,
                  ),
                  title: Text(user.userName!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!editOrDeleteUsers)
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 20.0),
                          onPressed: () {
                            // Ação quando o ícone de seta for pressionado
                          },
                        ),
                      if (editOrDeleteUsers)
                        IconButton(
                          icon:
                              Icon(Icons.edit, size: 20.0, color: Colors.blue),
                          onPressed: () {
                            // Ação quando o ícone de edição for pressionado
                            Map<String, dynamic> arguments = {
                              'user': user,                             
                              'isUpdateByAdmin': true,
                              'updatePassword': false
                            };

                            NavigationService.pushNamed('/register',
                                arguments: arguments);
                          },
                        ),
                      if (editOrDeleteUsers)
                        IconButton(
                          icon:
                              Icon(Icons.delete, size: 20.0, color: Colors.red),
                          onPressed: () {
                            // Ação quando o ícone de lixeira for pressionado
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text('Total de usuários: $total'),
          ),
        ],
      ),
    );
  }
}
