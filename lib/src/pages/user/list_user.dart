//codigo com provider funcionando
// import 'package:classifields_apk_flutter/src/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
// import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';
// import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';
// import 'package:classifields_apk_flutter/src/components/center_modal_inputs_buttons.dart';
// import 'package:classifields_apk_flutter/src/services/snack_bar_service.dart';

// import 'package:provider/provider.dart';
// import 'package:classifields_apk_flutter/src/Providers/user_provider.dart';

// import 'package:classifields_apk_flutter/src/components/input_component.dart';

// class UserListPage extends StatefulWidget {
//   UserListPage({Key? key}) : super(key: key);

//   @override
//   State<UserListPage> createState() => _UserListPageState();
// }

// class _UserListPageState extends State<UserListPage> {
//   bool editOrDeleteUsers = false;

//   final UserController userController = UserController();

//   final ScrollController _scrollController = ScrollController();

//   var nickNameController = TextEditingController();

//   bool isLoading = false;

//   List<UserModel> users = [];
//   int currentPage = 1;
//   int take = 7;
//   int total = 0;

//   @override
//   initState() {
//     super.initState();

//     _scrollController.addListener(_scrollListener);

//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     getAllUsers(userProvider);
//   }

//   void getAllUsers(UserProvider userProvider) async {
//     setState(() {
//                                 isLoading = true;
//                               });
//     await userProvider.getAllUsers(currentPage, take)
//     .then((value) => {
//                               setState(() {
//                                 isLoading = false;
//                               }),
//                             });
//   }

//   void _scrollListener() {
//     if (_scrollController.offset >=
//             _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange) {
//       currentPage++; // Incrementa a página atual
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       userProvider.getAllUsers(currentPage, take);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CustomColors.customSwatchColor,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('Lista de Usuários'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             userProvider.clearUsers();
//             Navigator.pop(context); // Limpar a lista de usuários
//           },
//         ),
//         actions: [
//           Container(
//             margin: EdgeInsets.only(right: 16.0),
//             child: IconButton(
//               icon: Icon(Icons.edit,
//                   size: 20.0,
//                   color: editOrDeleteUsers ? Colors.blue : Colors.white),
//               onPressed: () {
//                 setState(() {
//                   editOrDeleteUsers = !editOrDeleteUsers;
//                 });
//                 // Ação quando o ícone de edição na AppBar for pressionado
//               },
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           //BPTAO TIPO SEARCH QUE FAZ FILTRO LIKE PARA USERNAME
//           Container(
//             //width: 300, // Defina o tamanho lateral desejado
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             //margin: ,
//             child: InputComponent(
//               controller: nickNameController,
//               keyboardType: TextInputType.text,
//               icon: Icons.search,
//               label: 'Pesquise Usuário pelo NickName',
//               labelIntern: true,
//               searchButton: true,
//               clearInputSearchCallBack: () {
//                 //retorna quando clicar no clear (x) no input para limpar
//                 setState(() {
//                       isLoading = true;
//                     });
//                     userProvider.clearUsers();
//                     userProvider.getAllUsers(currentPage, take)
//                     .then((value) => {
//                               setState(() {
//                                 isLoading = false;
//                               }),
//                             });
//               },
//               onChanged: (value) => {
//                 if (value.length > 0)
//                   {
//                     setState(() {
//                       isLoading = true;
//                     }),
//                     userProvider
//                         .getUsersByUserNameLikeFilter(value)
//                         .then((value) => {
//                               setState(() {
//                                 isLoading = false;
//                               }),
//                             })
//                   }
//                 else
//                   {
//                     setState(() {
//                       isLoading = true;
//                     }),
//                     userProvider.clearUsers(),
//                     userProvider.getAllUsers(currentPage, take)
//                     .then((value) => {
//                               setState(() {
//                                 isLoading = false;
//                               }),
//                             })
//                   }
//               },
//             ),
//           ),
//           Expanded(
//             child: Consumer<UserProvider>(builder: (context, userProvider, _) {
//               return isLoading
//                   ? const Center(
//                       child: SizedBox(
//                         width: 40, // Defina o tamanho mínimo desejado aqui
//                         height: 40, // Defina o tamanho mínimo desejado aqui
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation(Colors.green),
//                         ),
//                       ),
//                     )
//                   : ListView.separated(
//                       controller: _scrollController,
//                       itemCount: userProvider.users.length,
//                       separatorBuilder: (context, index) => Divider(),
//                       itemBuilder: (context, index) {
//                         final user = userProvider.users[index];
//                         return ListTile(
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 16.0),
//                           leading: CircleAvatar(
//                             backgroundImage: user.mediaAvatar != null
//                                 ? NetworkImage(user.mediaAvatar!.url!)
//                                 : const Image(
//                                     image: AssetImage(
//                                         'assets/images/avatarzinho.jpg'),
//                                   ).image as ImageProvider<Object>?,
//                           ),
//                           title: Text(user.userName!),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               if (!editOrDeleteUsers)
//                                 IconButton(
//                                   icon: const Icon(Icons.arrow_forward_ios,
//                                       size: 20.0),
//                                   onPressed: () {
//                                     // Ação quando o ícone de seta for pressionado

//                                     NavigationService.pushNamed('/userProfile',
//                                         arguments: user);
//                                   },
//                                 ),
//                               if (editOrDeleteUsers)
//                                 IconButton(
//                                   icon: const Icon(Icons.edit,
//                                       size: 20.0, color: Colors.blue),
//                                   onPressed: () {
//                                     // Ação quando o ícone de edição for pressionado
//                                     Map<String, dynamic> arguments = {
//                                       'user': user,
//                                       'isUpdateByAdmin': true,
//                                       'updatePassword': false
//                                     };

//                                     NavigationService.pushNamed('/register',
//                                         arguments: arguments);
//                                   },
//                                 ),
//                               if (editOrDeleteUsers)
//                                 IconButton(
//                                   icon: const Icon(Icons.delete,
//                                       size: 20.0, color: Colors.red),
//                                   onPressed: () {
//                                     // Ação quando o ícone de lixeira for pressionado
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return CustomModal(
//                                           context: context,
//                                           title:
//                                               'Tem certeza que deseja DELETAR esse usuário?',
//                                           inputs: const [],
//                                           buttons: [
//                                             ButtonConfig(
//                                                 name: 'OK',
//                                                 color: Colors.green),
//                                             ButtonConfig(
//                                                 name: 'Cancelar',
//                                                 color: Colors.red),
//                                           ],
//                                           returnButtonNameClick: (value) {
//                                             if (value == 'OK') {
//                                               userController
//                                                   .deleteUserById(user.id)
//                                                   .then((deleted) => {
//                                                         if (deleted == true)
//                                                           {
//                                                             Future.delayed(
//                                                                 const Duration(
//                                                                     seconds: 0),
//                                                                 () {
//                                                               MySnackbar.show(
//                                                                   context,
//                                                                   'Usuário Deletado com sucesso!');
//                                                             }),
//                                                             Future.delayed(
//                                                                 const Duration(
//                                                                     seconds: 2),
//                                                                 () {
//                                                               userProvider
//                                                                   .removeUser(
//                                                                       user);
//                                                               Navigator.pop(
//                                                                   context);
//                                                             }),
//                                                           }
//                                                         else
//                                                           {
//                                                             {
//                                                               Future.delayed(
//                                                                   const Duration(
//                                                                       seconds:
//                                                                           0),
//                                                                   () {
//                                                                 MySnackbar.show(
//                                                                     context,
//                                                                     'Ocorreu algum erro ao tentar deletar usuário');
//                                                               }),
//                                                               Future.delayed(
//                                                                   const Duration(
//                                                                       seconds:
//                                                                           2),
//                                                                   () {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               }),
//                                                             }
//                                                           }
//                                                       });
//                                             }
//                                           },
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//             }),
//           ),
//           Container(
//             padding: EdgeInsets.all(16.0),
//             alignment: Alignment.center,
//             child: Text('Total de usuários: ${userProvider.total}'),
//           ),
//         ],
//       ),
//     );
//   }
// }

//codigo com getX
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';
import 'package:classifields_apk_flutter/src/components/center_modal_inputs_buttons.dart';
import 'package:classifields_apk_flutter/src/services/snack_bar_service.dart';

import 'package:provider/provider.dart';

import 'package:classifields_apk_flutter/src/Providers/user_getX.dart';
import 'package:get/get.dart';

import 'package:classifields_apk_flutter/src/components/input_component.dart';

class UserListPage extends StatefulWidget {
  UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool editOrDeleteUsers = false;

  final UserController userController = UserController();

  final ScrollController _scrollController = ScrollController();

  var nickNameController = TextEditingController();

  bool isLoading = false;

  final UserControllerGetx userControllerGetX = Get.find<UserControllerGetx>();

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

  void getAllUsers() async {
    setState(() {
                            isLoading = true;
                          });
    await userControllerGetX.getAllUsers(currentPage, take).then((value) => {
      setState(() {
                            isLoading = false;
                          }),
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      currentPage++; // Incrementa a página atual
      userControllerGetX.getAllUsers(currentPage, take);
    }
  }

  Future<void> _onRefresh() async {
    
    await Future.delayed(Duration(seconds: 2));
    
    userControllerGetX.getAllUsers(currentPage, take);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Lista de Usuários'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            userControllerGetX.clearUsers(); //=> aki
            Navigator.pop(context); // Limpar a lista de usuários
          },
        ),
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
          //BPTAO TIPO SEARCH QUE FAZ FILTRO LIKE PARA USERNAME
          Container(
            //width: 300, // Defina o tamanho lateral desejado
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            //margin: ,
            child: InputComponent(
              controller: nickNameController,
              keyboardType: TextInputType.text,
              icon: Icons.search,
              label: 'Pesquise Usuário pelo NickName',
              labelIntern: true,
              searchButton: true,
              clearInputSearchCallBack: () {
                //retorna quando clicar no clear (x) no input para limpar
                setState(() {
                  isLoading = true;
                });
                userControllerGetX.clearUsers();                              //=> aki
                userControllerGetX
                    .getAllUsers(currentPage, take)
                    .then((value) => {
                          setState(() {
                            isLoading = false;
                          })
                        });                                                 //=> aki
              },
              onChanged: (value) => {
                if (value.length > 0)
                  {
                    setState(() {
                            isLoading = true;
                          }),
                    userControllerGetX
                        .getUsersByUserNameLikeFilter(value).then((value) => {
                          setState(() {
                            isLoading = false;
                          })
                        })  //=> aki
                  }
                else
                  {
                    setState(() {
                            isLoading = true;
                          }),
                    userControllerGetX.clearUsers(),                                                                    //=> aki
                    userControllerGetX.getAllUsers(currentPage, take).then((value) => {
                          setState(() {
                            isLoading = false;
                          })
                        })                                                                                              //=> aki
                  }
              },
            ),
          ),
          Expanded(
            child: GetBuilder<UserControllerGetx>(//=> aki
                builder: (controller) {
              final users = controller.users; //=> aki
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: users.length, //=> aki
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final user = users[index]; //=> aki
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      leading: CircleAvatar(
                        backgroundImage: user.mediaAvatar != null
                            ? NetworkImage(user.mediaAvatar!.url!)
                            : const Image(
                                image:
                                    AssetImage('assets/images/avatarzinho.jpg'),
                              ).image as ImageProvider<Object>?,
                      ),
                      title: Text(user.userName!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!editOrDeleteUsers)
                            IconButton(
                              icon:
                                  const Icon(Icons.arrow_forward_ios, size: 20.0),
                              onPressed: () {
                                // Ação quando o ícone de seta for pressionado
              
                                NavigationService.pushNamed('/userProfile',
                                    arguments: user);
                              },
                            ),
                          if (editOrDeleteUsers)
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  size: 20.0, color: Colors.blue),
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
                              icon: const Icon(Icons.delete,
                                  size: 20.0, color: Colors.red),
                              onPressed: () {
                                // Ação quando o ícone de lixeira for pressionado
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomModal(
                                      context: context,
                                      title:
                                          'Tem certeza que deseja DELETAR esse usuário?',
                                      inputs: const [],
                                      buttons: [
                                        ButtonConfig(
                                            name: 'OK', color: Colors.green),
                                        ButtonConfig(
                                            name: 'Cancelar', color: Colors.red),
                                      ],
                                      returnButtonNameClick: (value) {
                                        if (value == 'OK') {
                                          userController
                                              .deleteUserById(user.id)
                                              .then((deleted) => {
                                                    if (deleted == true)
                                                      {
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 0), () {
                                                          MySnackbar.show(context,
                                                              'Usuário Deletado com sucesso!');
                                                        }),
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2), () {
                                                          userControllerGetX
                                                              .removeUser(
                                                                  user); //=> aki
                                                          Navigator.pop(context);
                                                        }),
                                                      }
                                                    else
                                                      {
                                                        {
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 0),
                                                              () {
                                                            MySnackbar.show(
                                                                context,
                                                                'Ocorreu algum erro ao tentar deletar usuário');
                                                          }),
                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 2),
                                                              () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                        }
                                                      }
                                                  });
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text('Total de usuários: ${userControllerGetX.total}'),
          ),
        ],
      ),
    );
  }
}
