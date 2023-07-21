import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';

import 'package:classifields_apk_flutter/src/components/menu_component_widget.dart';
import 'package:classifields_apk_flutter/src/components/center_modal_inputs_buttons.dart';
import 'package:classifields_apk_flutter/src/services/snack_bar_service.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';

import 'package:classifields_apk_flutter/src/components/footer_tabs_component.dart';
import 'package:classifields_apk_flutter/src/pages/user/user_profile.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SignInController authController = SignInController();

  Widget? _screen;
  bool showAppBar = false;
  bool showAppBarWhenScroll = false;

  List<FooterTabItem> tabs = [
    FooterTabItem(icon: Icons.home, name: 'home', index: 0),
    FooterTabItem(icon: Icons.search, name: 'search', index: 1),
    FooterTabItem(icon: Icons.favorite, name: 'favorite', index: 2),
    FooterTabItem(icon: Icons.person, name: 'person', index: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar && !showAppBarWhenScroll
          ? AppBar(
              automaticallyImplyLeading: false, // Remove a seta de voltar
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
            )
          : null,
      endDrawer: MenuComponentWidget(
        // Define o endDrawer para um menu lateral no lado direito
        pageCallThisComponent: 'home',
        onItemSelected: (value, userId) {
          if (value == 'Excluir Cadastro') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomModal(
                  context: context,
                  title: 'Tem certeza que deseja DELETAR esse usuário?',
                  inputs: [],
                  buttons: [
                    ButtonConfig(name: 'OK', color: Colors.green),
                    ButtonConfig(name: 'Cancelar', color: Colors.red),
                  ],
                  returnButtonNameClick: (value) {
                    if (value == 'OK') {
                      userController.deleteUserById(userId).then((deleted) => {
                            if (deleted == true)
                              {
                                Future.delayed(const Duration(seconds: 0), () {
                                  MySnackbar.show(
                                      context, 'Usuário Deletado com sucesso!');
                                }),
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                  NavigationService.pushNamed('/login');
                                }),
                              }
                            else
                              {
                                {
                                  Future.delayed(const Duration(seconds: 0),
                                      () {
                                    MySnackbar.show(context,
                                        'Ocorreu algum erro ao tentar deletar usuário');
                                  }),
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    Navigator.pop(context);
                                  }),
                                }
                              }
                          });
                    }
                  },
                );
              },
            );
          }
        },
      ),      

      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              showAppBarWhenScroll = notification.scrollDelta! < 0;
            });
          }
          return false;
        },
        child: Navigator(
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              builder: (context) {
                return _screen ?? Container();
              },
            );
          },
        ),
      ),


      bottomNavigationBar: FooterTabsComponent(
        tabs: tabs,
        onTabSelected: (name) {
          print('name $name');
          if (name == 'person') {
            setState(() {
              showAppBar = true;
              _screen = UserProfile();
            });
          } else {
            setState(() {
              showAppBar = true;
              _screen = Container();
            });
          }
        },
      ),

      // Adicione o componente FooterComponent aqui
    );
  }
}
