import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/components/input_component.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final birthdateController = TextEditingController();
  final nickNameController = TextEditingController();
  final realNameController = TextEditingController();
  final emailController = TextEditingController();
  final bithDateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  //TITULO DA TELA
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

                  //CONTAINER FORMULARIO
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        )),
                    child: Form(
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputComponent(
                            controller: nickNameController,
                            keyboardType: TextInputType.text,
                            icon: Icons.account_circle,
                            label: 'NickName',
                            validator: (nickName) {
                              if (nickName == null || nickName.isEmpty) {
                                return 'Escolha um nickName';
                              }
                              if (nickName.length < 2) {
                                return 'Digite um nickname com pelo menos 2 caracteres.';
                              }

                              return null;
                            },
                          ),
                          InputComponent(
                            controller: realNameController,
                            keyboardType: TextInputType.text,
                            icon: Icons.person,
                            label: 'Nome completo',
                            validator: (realName) {
                              if (realName == null || realName.isEmpty) {
                                return 'Cadastre seu nome completo';
                              }
                              return null;
                            },
                          ),
                          InputComponent(
                            controller: emailController,
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
                          InputComponent(
                            controller: birthdateController,
                            keyboardType: TextInputType.none,
                            icon: Icons.calendar_month,
                            label: 'Data de Nascimento',
                            readOnly: true,
                            isDate: true,
                            validator: (bithDate) {
                              if (bithDate == null || bithDate.isEmpty) {
                                return 'Cadastre sua data de nascimento';
                              }
                              return null;
                            },
                          ),
                          InputComponent(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Digite sua senha';
                              }

                              return null;
                            },
                          ),
                          InputComponent(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            icon: Icons.lock,
                            label: 'Confirmação da Senha',
                            isSecret: true,
                            validator: (confirmPassword) {
                              if (confirmPassword == null ||
                                  confirmPassword.isEmpty) {
                                return 'Digite sua a confirmação da senha';
                              }

                              if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return 'Senha e Confirmacão de senha devem ser iguais';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    String realName = realNameController.text;
                                    String nickName = nickNameController.text;
                                    String email = emailController.text;
                                    String birthDate = birthdateController.text;
                                    String password = passwordController.text;
                                    String confirmPassword =
                                        confirmPasswordController.text;

                                    realNameController.text = '';
                                    nickNameController.text = '';
                                    emailController.text = '';
                                    birthdateController.text = '';
                                    passwordController.text = '';
                                    confirmPasswordController.text = '';

                                    print(
                                        '$nickName, $realName, $email, $birthDate, $password, $confirmPassword');
                                  }
                                },
                                child: const Text(
                                  'Cadastrar Usuário',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //Seta para voltar para o login
              Positioned(
                  top: 10,
                  left: 10,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
