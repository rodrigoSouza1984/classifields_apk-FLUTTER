import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/components/input_component.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(children: [
        Expanded(
          child: Container(
            color: Colors.red,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 40,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45))),
            child: Column(
              children: [
                //email
                InputComponent(
                  controller: emailCtrl,
                  keyboardType:TextInputType.emailAddress,
                  icon: Icons.email,
                  label: 'Email',
                ),

                //senha
                InputComponent(
                  controller: passwordCtrl,
                  keyboardType:TextInputType.text,
                  icon: Icons.lock,
                  label: 'Senha',
                  isSecret: true,
                ),

                InputComponent(   
                  keyboardType:TextInputType.none,      
                  controller: birthdateCtrl,         
                  icon: Icons.calendar_month,
                  label: 'Data de Nascimento',
                  readOnly: true, 
                  isDate: true,                 
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
