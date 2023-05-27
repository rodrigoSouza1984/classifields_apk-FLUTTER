import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/components/input_component.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();

  final _formkey = GlobalKey<FormState>();

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
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  //email
                  InputComponent(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                    label: 'Email',
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Digite seu Email';
                      }

                      if (!email.contains('@')) {
                        return 'Digite um email válido';
                      }

                      return null;
                    },
                  ),

                  //senha
                  InputComponent(
                    controller: passwordCtrl,
                    keyboardType: TextInputType.text,
                    icon: Icons.lock,
                    label: 'Senha',
                    isSecret: true,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Digite sua senha';
                      }

                      if (password.length < 7) {
                        return 'Digite uma senha com pelo menos 7 caracteres.';
                      }

                      return null;
                    },
                  ),

                  InputComponent(
                    keyboardType: TextInputType.none,
                    controller: birthdateCtrl,
                    icon: Icons.calendar_month,
                    label: 'Data de Nascimento',
                    readOnly: true,
                    isDate: true,
                  ),

                  //Botao de entrar
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                                                    
                          if (_formkey.currentState!.validate()) {
                            String email = emailCtrl.text;
                            String password = passwordCtrl.text;
                            print('${email}, ${password}');
                          } else {
                            print('Campos não válidos');
                          }                          
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
