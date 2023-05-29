import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/components/app_name_widget.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SignInController authController = SignInController();
  
  @override
  void initState() {							
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      authController.validateToken().then((value) => {	
            print(value == true),
            if (value != true)
              {
                Navigator.of(context).pushNamed(
                  '/login',
                  arguments: null,
                )
              }
            else            
              {
                print('aki para home'),
                Navigator.of(context).pushNamed(
                  '/home',
                  arguments: null,
                )
              }
          });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700
            ],
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppNameWidget(
              greenTitleColor: Colors.white,
              textSize: 40,
            ),

            SizedBox(height: 10),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )            
          ],
        ),
      ),
    );
  }
}