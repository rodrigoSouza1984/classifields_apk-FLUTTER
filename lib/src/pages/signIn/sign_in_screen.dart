import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/components/input_component.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeTela = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
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

                    const SizedBox(
                      height: 8,
                    ),

                    //
                    //BOTAO ESQUECEU SENHA
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
