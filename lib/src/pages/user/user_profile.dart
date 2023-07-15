import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: Column(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),

                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/avatarzinho.jpg'),
                  ),
                ),

                SizedBox(height: 30),
                // Espaçamento entre o avatar e o texto
                Text(
                  'Rodrigo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ],
            ),
          ),

          
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SafeArea(
                    top: false,
                    child: AppBar(
                      toolbarHeight: 0, // Defina a altura desejada
                      elevation: 0, // Remova as bordas do AppBar
                      backgroundColor: Colors.white,
                      flexibleSpace: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 0),
                          child: Container(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [

                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            null, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: const Text(
                                        'Todos',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: Colors
                                              .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            null, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: const Text(
                                        'Casas',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: Colors
                                              .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            null, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: const Text(
                                        'Chacáras',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: Colors
                                              .grey, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Ação do primeiro botão
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .grey, // Defina a cor de fundo desejada
                                        borderRadius: BorderRadius.circular(
                                            8), // Ajuste o raio do canto do botão
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical:
                                              8), // Ajuste o espaçamento interno do botão
                                      child: const Text(
                                        'Salão de Festas',
                                        style: TextStyle(
                                          fontSize:
                                              12, // Ajuste o tamanho do texto
                                          color: Colors
                                              .white, // Ajuste a cor do texto
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Restante do conteúdo aqui
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
