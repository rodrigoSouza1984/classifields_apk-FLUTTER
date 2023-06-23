import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';

import 'package:classifields_apk_flutter/src/components/menu_component_widget.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final SignInController authController = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),      
      endDrawer: MenuComponentWidget( // Define o endDrawer para um menu lateral no lado direito
          onItemSelected: (value) {
            print('$value, 9999');
          },
        ),
    );
  }
}
