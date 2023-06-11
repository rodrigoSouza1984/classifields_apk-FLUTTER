import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/components/input_component.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';
import 'package:classifields_apk_flutter/src/services/navigator_service_without_context.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/components/toast_message_component.dart';
import 'package:classifields_apk_flutter/src/components/center_modal_inputs_buttons.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final SignInController authController = SignInController();

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();

  final emailCtrl2 = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void showMyToast(BuildContext context, String message, Duration duration) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastModal(
        message: message,
        duration: duration,
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Future.delayed(Duration(seconds: 3), () {//SEM PARAMETRO O TEMPO
    //   overlayEntry.remove();
    // });

    Future.delayed(duration, () {
      //POR PARAMETRO O TEMPO
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeTela = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: sizeTela.height,
          width: sizeTela.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //
            //parte de cima TITULO DA TELA E ANIMACOES
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                    ),
                    children: [
                      TextSpan(
                        text: 'Classi',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Fields',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                //categorias
                SizedBox(
                  height: 30,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                    child: AnimatedTextKit(
                      pause: Duration.zero,
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText('Salão de Festas'),
                        FadeAnimatedText('Chácaras'),
                        FadeAnimatedText('Casas'),
                        FadeAnimatedText('Apartamentos'),
                        FadeAnimatedText('Na Sua Cidade !!!'),
                      ],
                    ),
                  ),
                )
              ],
            )),
            //
            //parte de baixo formulario
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 40,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //
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
                    //
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
                    //
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
                              print('${email}, ${password}, inputs');

                              authController
                                  .signIn(email: email, password: password)
                                  .then((value) => {
                                        print('$value, return button'),
                                        if (value == true)
                                          {
                                            emailCtrl.text = '',
                                            passwordCtrl.text = '',
                                            Navigator.of(context).pushNamed(
                                              '/home',
                                              arguments: null,
                                            )
                                          }
                                        else
                                          {
                                            showMyToast(
                                                context,
                                                'Login não realizado, Email ou Password inválido',
                                                const Duration(seconds: 3))
                                          }
                                      });
                            } else {
                              print('Campos não válidos');
                            }
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18),
                          )),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //
                    //BOTAO ESQUECEU SENHA
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomModal(
                                context: context,
                                title: 'Esqueceu Sua Senha?',
                                inputs: [
                                  TextFormField(
                                    controller: emailCtrl2,
                                    decoration: const InputDecoration(
                                        labelText: 'Email'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Digite seu Email';
                                      }

                                      if (!value.contains('@')) {
                                        return 'Digite um email válido';
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                                buttons: [
                                  ButtonConfig(name: 'OK', color: Colors.green),
                                  ButtonConfig(
                                      name: 'Cancelar', color: Colors.red),
                                ],
                                returnModalForgetPassword: (value) {
                                  FocusScope.of(context).unfocus();

                                  if (emailCtrl2.text != null) {
                                    authController
                                        .forgetedPassword(
                                            email: emailCtrl2.text)
                                        .then((value) => {
                                              if (value == null)
                                                {
                                                  showMyToast(
                                                      context,
                                                      'Algum erro aconteceu verifique se o email foi digitado corretamente, ou entre em contato com o suporte.',
                                                      const Duration(
                                                          seconds: 8)),
                                                  Future.delayed(
                                                      Duration(seconds: 1), () {
                                                    Navigator.pop(context);
                                                  })
                                                }
                                              else
                                                {
                                                  print(
                                                      '${value.runtimeType}, returned forget password api'),
                                                  showMyToast(
                                                      context,
                                                      value,
                                                      const Duration(
                                                          seconds: 5)),
                                                  Future.delayed(
                                                      Duration(seconds: 1), () {
                                                    Navigator.pop(context);
                                                  })
                                                }
                                            });
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Esqueceu a Senha?',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),

                    //LINHA CINZA DIVIDIDA EM 2 COM PALAVRA OU NO MEIO
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withAlpha(99),
                            thickness: 2,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Ou'),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withAlpha(99),
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            side: const BorderSide(
                                width: 2, color: Colors.green)),
                        onPressed: () {
                          NavigationService.pushNamed('/register');
                        },
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
