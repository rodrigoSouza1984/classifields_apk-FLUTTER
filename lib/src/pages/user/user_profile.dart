import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';

import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final UserController userController = UserController();
  UserModel user = UserModel();
  String selectedButton = 'Todos';
  UserModel? userNavigation;
  bool userByNavigation = false;

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Acesso aos argumentos da rota
      userNavigation = ModalRoute.of(context)?.settings.arguments as UserModel?;     

      print('user user ${user.userName}');

      if (userNavigation != null) {

        final UserModel userGetNavigation = userNavigation as UserModel;

        setState(() {
          user = userGetNavigation;
          userByNavigation = true;
        });
      } else {
        getLocalUser();
      }
    });
  }

  getLocalUser() async {
    final userLocal = await userController.userLocalData();

    if (userLocal != null) {
      setState(() {
        user = userLocal;
      });
    } else {
      print(
          'erro ao buscar usuario no storage $userLocal, metodo : getLocalUser');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,

      appBar: userByNavigation ? AppBar(
              automaticallyImplyLeading: true, // Remove a seta de voltar
              backgroundColor: CustomColors.customSwatchColor,
              elevation: 0,
              centerTitle: true,
              title: Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Classi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Fields',
                      style: TextStyle(
                        color: CustomColors.customContrastColor,
                      ),
                    ),
                  ],
                ),
              ),
            ): null,

      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 10),

                Align(
                  alignment: Alignment.center,
                  child: user.mediaAvatar?.url != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(user.mediaAvatar?.url ?? ''),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/avatarzinho.jpg'),
                        ),
                ),

                const SizedBox(height: 30),
                // Espaçamento entre o avatar e o texto
                Text(
                  user.userName ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SafeArea(
                    top: false,
                    child: AppBar(
                      toolbarHeight: 0, // Defina a altura desejada
                      elevation: 0, // Remova as bordas do AppBar
                      backgroundColor: Colors.white,
                      flexibleSpace: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 0),
                          child: Container(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                      setState(() {
                                        selectedButton = 'Todos';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedButton == 'Todos'
                                            ? Colors.grey
                                            : Colors
                                                .white, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: Text(
                                        'Todos',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: selectedButton == 'Todos'
                                              ? Colors.white
                                              : Colors
                                                  .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                      setState(() {
                                        selectedButton = 'Casas';
                                      });

                                      print('casas $selectedButton');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedButton == 'Casas'
                                            ? Colors.grey
                                            : Colors
                                                .white, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: Text(
                                        'Casas',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: selectedButton == 'Casas'
                                              ? Colors.white
                                              : Colors
                                                  .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                      setState(() {
                                        selectedButton = 'Chacáras';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedButton == 'Chacáras'
                                            ? Colors.grey
                                            : Colors
                                                .white, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: Text(
                                        'Chacáras',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: selectedButton == 'Chacáras'
                                              ? Colors.white
                                              : Colors
                                                  .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                      setState(() {
                                        selectedButton = 'Salão de Festas';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedButton ==
                                                'Salão de Festas'
                                            ? Colors.grey
                                            : Colors
                                                .white, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: Text(
                                        'Salão de Festas',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: selectedButton ==
                                                  'Salão de Festas'
                                              ? Colors.white
                                              : Colors
                                                  .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Restante do conteúdo aqui
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
