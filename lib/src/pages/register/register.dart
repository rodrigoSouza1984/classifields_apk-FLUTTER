import 'dart:io';
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
  Register({
    Key? key,
  }) : super(key: key);

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

  UserModel? user;
  bool isUpdate = false;
  bool isUpdateImage = false;
  String? imageUrlCameRoute = '';

  bool validarSenha(String password) {
    //validator password function
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[\W_]).{7,}$');
    return regex.hasMatch(password);
  }

  int? validateBirthDateOver18YearsOld(String birthDate) {
    //validator date maler 18 years old
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

  bool emailExistsValidator = false;

  var birthdateController = TextEditingController();

  var nickNameController = TextEditingController();

  var realNameController = TextEditingController();

  var emailController = TextEditingController();

  var bithDateController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Acesso aos argumentos da rota
      user = ModalRoute.of(context)?.settings.arguments as UserModel?;

      if (user != null) {
        setState(() {
          isUpdate = true;
          isUpdateImage = true;

          if (user?.mediaAvatar?.url != null) {
            imageUrlCameRoute = user?.mediaAvatar?.url;
          }

          nickNameController = TextEditingController(text: user!.userName);
          realNameController = TextEditingController(text: user?.realName);
          emailController = TextEditingController(text: user?.email);
          birthdateController = TextEditingController(text: user?.dateOfBirth);
        });
      }
    });
  }

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
                  !isUpdate
                      ? const Expanded(
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
                        )
                      : const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Center(
                              child: Text(
                                'Dados Do Usuário',
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
                    constraints: BoxConstraints( //constraints he go even 88% max of screen in the heigth
                      maxHeight: MediaQuery.of(context).size.height * 0.88,
                    ),
                    padding: const EdgeInsets.only(
                        top: 20, left: 32, right: 32, bottom: 40),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        )),
                    child: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Avatar
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                isUpdateImage
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: imageUrlCameRoute != ''
                                            ? NetworkImage(imageUrlCameRoute!)
                                            : const Image(
                                                image: AssetImage(
                                                    'assets/images/avatarzinho.jpg'),
                                              ).image as ImageProvider<Object>?,
                                      )
                                    : CircleAvatar(
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
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
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
                                            title:
                                                'Adicione uma Foto de Perfil',
                                            icon: Icons.delete,
                                            iconsWithTitles: const [
                                              MapEntry(
                                                  Icons.camera_alt, 'Câmera'),
                                              MapEntry(Icons.photo,
                                                  'Imagem Galeria'),
                                              // MapEntry(
                                              //     Icons.video_library, 'Vídeo'),
                                            ],
                                          );
                                        },
                                      );
                                      print(
                                          'Resultado do modal: ${result['selectedItem']}');

                                      if (result['selectedItem'] != '') {
                                        setState(() {
                                          _image = result['image'];
                                          _imagePath = result['imagePath'];

                                          isUpdateImage = false;
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

                                        if (isUpdate) {
                                          if (isLoading == true) {
                                            return;
                                          }

                                          setState(() {
                                            isLoading =
                                                true; // Ativar o estado de carregamento
                                          });

                                          if (imageUrlCameRoute != '') {
                                            await userController
                                                .deleteImageAvatar(user?.id,
                                                    user?.mediaAvatar?.name)
                                                .then((value) async {
                                              if (value == true) {
                                                await userController
                                                    .addMediaAvatarUser(
                                                        user?.id, userAvatar)
                                                    .then((value) {
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    MySnackbar.show(context,
                                                        'Imagem adicionada/trocada com sussesso!.');
                                                  });
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    setState(() {
                                                      imageUrlCameRoute = '';
                                                      isLoading =
                                                          false; // Desativar o estado de carregamento
                                                    });
                                                  });
                                                });
                                              }
                                            });
                                          } else {
                                            await userController
                                                .addMediaAvatarUser(
                                                    user?.id, userAvatar)
                                                .then((value) {
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                MySnackbar.show(context,
                                                    'Imagem adicionada/trocada com sussesso!.');
                                              });
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                setState(() {
                                                  imageUrlCameRoute = '';
                                                  isLoading =
                                                      false; // Desativar o estado de carregamento
                                                });
                                              });
                                            });
                                          }
                                        }

                                        // Use o objeto "imageObject" conforme necessário
                                        print(
                                            '${_image.runtimeType} , objeto image');
                                      } else {
                                        setState(() {
                                          _image = null;
                                          _imagePath = null;
                                        });

                                        userAvatar = null;

                                        if (isUpdate) {
                                          if (isLoading == true) {
                                            return;
                                          }

                                          setState(() {
                                            isLoading =
                                                true; // Ativar o estado de carregamento
                                          });

                                          await userController
                                              .deleteImageAvatar(user?.id,
                                                  user?.mediaAvatar?.name)
                                              .then((value) {
                                            if (value == true) {
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                MySnackbar.show(context,
                                                    'Imagem apagada com sussesso!.');
                                              });
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                setState(() {
                                                  imageUrlCameRoute = '';
                                                  isLoading =
                                                      false; // Desativar o estado de carregamento
                                                });
                                              });
                                            }
                                          });
                                        }

                                        print('${userAvatar} , objeto image');
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            InputComponent(
                              controller: nickNameController,
                              valueStartInpuWhenIsUpdat: isUpdate
                                  ? TextEditingController(text: user?.userName)
                                  : null,
                              keyboardType: TextInputType.text,
                              icon: Icons.account_circle,
                              label: 'NickName',
                              isUpdate: isUpdate ? isUpdate : false,
                              errorText: true,
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
                              isUpdate: isUpdate ? isUpdate : false,
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
                              valueStartInpuWhenIsUpdat: isUpdate
                                  ? TextEditingController(text: user?.email)
                                  : null,
                              keyboardType: TextInputType.emailAddress,
                              isUpdate: isUpdate ? isUpdate : false,
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
                              isUpdate: isUpdate ? isUpdate : false,
                              icon: Icons.calendar_month,
                              label: 'Data de Nascimento',
                              readOnly: true,
                              isDate: true,
                              validator: (bithDate) {
                                if (bithDate == null ||
                                    bithDate.isEmpty ||
                                    bithDate.toLowerCase() == 'n/a') {
                                  return 'Cadastre sua data de nascimento, é obrigatório';
                                }

                                if (bithDate != null &&
                                    bithDate.isNotEmpty &&
                                    bithDate.toLowerCase() != 'n/a') {
                                  if (validateBirthDateOver18YearsOld(
                                          birthdateController.text)! <
                                      18) {
                                    return 'É necessário ter pelo menos 18 anos.';
                                  }
                                }

                                return null;
                              },
                            ),
                            if (!isUpdate)
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
                            if (!isUpdate)
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
                              child: !isUpdate
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18))),
                                      onPressed: () async {
                                        if (isLoading == true) {
                                          return;
                                        }

                                        setState(() {
                                          isLoading =
                                              true; // Ativar o estado de carregamento
                                        });

                                        FocusScope.of(context).unfocus();

                                        if (_formkey.currentState!.validate()) {
                                          UserModel? userJson =
                                              UserModel.fromJson({});

                                          await userController.createUser({
                                            'userName': nickNameController.text,
                                            'realName': realNameController.text,
                                            'email': emailController.text,
                                            'dateOfBirth':
                                                birthdateController.text,
                                            'password': passwordController.text,
                                            'confirmPassword':
                                                confirmPasswordController.text,
                                            'mediaAvatar': userAvatar
                                          }).then((resp) => {
                                                // print(
                                                //     '$resp, resp create, ${resp != null}'),
                                                if (resp != null)
                                                  {
                                                    realNameController.text =
                                                        '',
                                                    nickNameController.text =
                                                        '',
                                                    emailController.text = '',
                                                    birthdateController.text =
                                                        '',
                                                    passwordController.text =
                                                        '',
                                                    confirmPasswordController
                                                        .text = '',
                                                    setState(() {
                                                      _image = null;
                                                      _imagePath = null;
                                                    }),
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 1), () {
                                                      MySnackbar.show(context,
                                                          'Parabens!!! Cadastro realizado com sussesso! Realize o Login e aproveite.');
                                                    }),
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      setState(() {
                                                        isLoading =
                                                            false; // Desativar o estado de carregamento
                                                      });
                                                      Navigator.of(context)
                                                          .pushNamed(
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
                                        } else {
                                          setState(() {
                                            isLoading =
                                                false; // Desativar o estado de carregamento
                                          });
                                        }
                                      },
                                      child: isLoading
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ) // Mostrar um indicador de carregamento
                                          : const Text(
                                              'Cadastrar Usuário',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18))),
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();

                                        if (isLoading == true) {
                                          return;
                                        }

                                        setState(() {
                                          isLoading =
                                              true; // Ativar o estado de carregamento
                                        });

                                        FocusScope.of(context).unfocus();

                                        if (_formkey.currentState!.validate()) {
                                          await userController.updatePatchUser(
                                              user?.id, {
                                            'userName': nickNameController.text,
                                            'realName': realNameController.text,
                                            'email': emailController.text,
                                            'dateOfBirth':
                                                birthdateController.text,
                                          }).then((resp) => {
                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  MySnackbar.show(context,
                                                      'Dados atualizados com sussesso.');
                                                }),
                                                Future.delayed(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  setState(() {
                                                    isLoading =
                                                        false; // Desativar o estado de carregamento
                                                  });
                                                }),
                                              });
                                        } else {
                                          setState(() {
                                            isLoading =
                                                false; // Ativar o estado de carregamento
                                          });
                                        }
                                      },
                                      child: isLoading
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ) // Mostrar um indicador de carregamento
                                          : const Text(
                                              'Atualizar Dados',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                    ),
                            )
                          ],
                        ),
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
