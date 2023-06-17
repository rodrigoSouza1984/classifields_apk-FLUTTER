import 'dart:io';

import 'package:classifields_apk_flutter/src/models/user_media_avatar_model.dart';
import 'package:classifields_apk_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';
import 'package:classifields_apk_flutter/src/components/input_component.dart';
import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';
import 'package:classifields_apk_flutter/src/services/image_video_photo_image_picker.dart';
import 'package:classifields_apk_flutter/src/components/menu_modal_icon_buttons.dart';
import 'package:classifields_apk_flutter/src/services/snack_bar_service.dart';

import 'dart:convert';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? _image;
  String? _imagePath;
  Map<String, dynamic>? userAvatar;
  bool isLoading = false;

  final UserController userController = UserController();

  final imageVideoPhotoService = ImageVideoPhotoService();

  bool validarSenha(String password) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[\W_]).{7,}$');
    return regex.hasMatch(password);
  }

  Future<dynamic>? createUserNameUnique(String userName) async {
    dynamic value = await userController.createUserNameUnique(userName);

    print('$value');

    return value;
  }

  int? validateBirthDateOver18YearsOld(String birthDate) {
    if (birthDate == null || birthDate.isEmpty) {
      return null;
    }

    // Parse da data de nascimento recebida
    final birthYear = int.parse(birthDate.substring(6));

    // Ano atual
    final currentYear = DateTime.now().year;

    // Cálculo da diferença de idade
    final ageDifference = currentYear - birthYear;

    return ageDifference;
  }  

  List<dynamic>? nickNameValidator = [];

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
                    child: Padding(
                      padding: EdgeInsets.only(top: 60),
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
                  ),

                  //CONTAINER FORMULARIO
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 32, right: 32, bottom: 40),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        )),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Avatar
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                backgroundImage: _imagePath != null
                                    ? FileImage(File(_imagePath!))
                                    : const Image(
                                        image: AssetImage(
                                            'assets/images/avatarzinho.jpg'),
                                      ).image as ImageProvider<Object>?,
                              ),
                              Positioned(
                                top: 65,
                                bottom: 0,
                                child: IconButton(
                                  onPressed: () async {
                                    final result =
                                        await showModalBottomSheet<dynamic>(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(45)),
                                      ),
                                      builder: (BuildContext context) {
                                        return MenuModalIconButtons(
                                          title: 'Adicione uma Foto de Perfil',
                                          icon: Icons.delete,
                                          iconsWithTitles: const [
                                            MapEntry(
                                                Icons.camera_alt, 'Câmera'),
                                            MapEntry(
                                                Icons.photo, 'Imagem Galeria'),
                                            // MapEntry(
                                            //     Icons.video_library, 'Vídeo'),
                                          ],
                                        );
                                      },
                                    );
                                    print(
                                        'Resultado do modal: ${result['selectedItem'] == ''}');

                                    if (result['selectedItem'] != '') {
                                      setState(() {
                                        _image = result['image'];
                                        _imagePath = result['imagePath'];
                                      });

                                      String base64Image = base64Encode(
                                          result['image'].readAsBytesSync());
                                      String timestamp = DateTime.now()
                                          .toUtc()
                                          .toIso8601String();
                                      String mimeType = 'image/jpeg';

                                      Map<String, dynamic> imageObjectMap = {
                                        'name': '$timestamp.jpeg',
                                        'base64':
                                            'data:image/jpeg;base64,$base64Image',
                                        'mimeType': mimeType,
                                      };

                                      userAvatar = imageObjectMap;

                                      // Use o objeto "imageObject" conforme necessário
                                      print(
                                          '${_image.runtimeType} , objeto image');
                                    } else {
                                      setState(() {
                                        _image = null;
                                        _imagePath = null;
                                      });

                                      userAvatar = null;

                                      print('${userAvatar} , objeto image');
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          InputComponent(
                            controller: nickNameController,
                            keyboardType: TextInputType.text,
                            icon: Icons.account_circle,
                            label: 'NickName',
                            errorText: true,                            
                            validator: (nickName) {
                              if (nickName == null || nickName.isEmpty) {
                                return 'Escolha um nickName';
                              }
                              if (nickName.length < 2) {
                                return 'Digite um nickname com pelo menos 2 caracteres.';
                              }
                              if (nickNameValidator?[0] != nickName) {
                                return 'NickName já existe , \nsugestões: ${nickNameValidator?[0]} , \n${nickNameValidator?[1]} , ${nickNameValidator?[2]}';
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
                            errorText: true,
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

                              if (validateBirthDateOver18YearsOld(
                                      birthdateController.text)! <
                                  18) {
                                return 'É necessário ter pelo menos 18 anos para se cadastrar.';
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

                              if (!validarSenha(password)) {
                                return 'Digite uma senha com pelo menos 7 caracteres \ncom no minimo 1 caracter especial \ne 1 letra maiuscula.';
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
                                      borderRadius: BorderRadius.circular(18))),
                              onPressed: () async {
                                if (isLoading == true) {
                                  return;
                                }

                                setState(() {
                                  isLoading =
                                      true; // Ativar o estado de carregamento
                                });

                                FocusScope.of(context).unfocus();

                                nickNameValidator = await createUserNameUnique(
                                    nickNameController.text);

                                if (nickNameValidator!.isNotEmpty &&
                                    nickNameValidator?[0] !=
                                        nickNameController.text) {
                                  setState(() {
                                    isLoading =
                                        false; // Desativar o estado de carregamento
                                  });
                                }

                                if (_formkey.currentState!.validate()) {
                                  UserModel? userJson = UserModel.fromJson({});

                                  await userController.createUser({
                                    'userName': nickNameController.text,
                                    'realName': realNameController.text,
                                    'email': emailController.text,
                                    'birthDate': birthdateController.text,
                                    'password': passwordController.text,
                                    'confirmPassword':
                                        confirmPasswordController.text,
                                    'mediaAvatar': userAvatar
                                  }).then((resp) => {
                                        // print(
                                        //     '$resp, resp create, ${resp != null}'),
                                        if (resp != null)
                                          {
                                            realNameController.text = '',
                                            nickNameController.text = '',
                                            emailController.text = '',
                                            birthdateController.text = '',
                                            passwordController.text = '',
                                            confirmPasswordController.text = '',
                                            setState(() {
                                              _image = null;
                                              _imagePath = null;
                                            }),
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              MySnackbar.show(context,
                                                  'Parabens!!! Cadastro realizado com sussesso! Realize o Login e aproveite.');
                                            }),
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              setState(() {
                                                isLoading =
                                                    false; // Desativar o estado de carregamento
                                              });
                                              Navigator.of(context).pushNamed(
                                                '/login',
                                                arguments: null,
                                              );
                                            }),
                                          }
                                        else
                                          {
                                            setState(() {
                                              isLoading =
                                                  false; // Desativar o estado de carregamento
                                            }),
                                            MySnackbar.show(context,
                                                'Humm...Houve algum erro na criacão do usuário, tente novamente se o erro persistir entre em contato cmo suporte')
                                          }
                                      });
                                }
                              },
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ) // Mostrar um indicador de carregamento
                                  : const Text(
                                      'Cadastrar Usuário',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
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
