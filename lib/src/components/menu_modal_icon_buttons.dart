import 'dart:io';

import 'package:flutter/material.dart';

import 'package:classifields_apk_flutter/src/services/image_video_photo_image_picker.dart';

class MenuModalIconButtons extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final List<MapEntry<IconData, String>> iconsWithTitles;

  String selectedItem = '';
  File? image;
  String? imagePath;

  MenuModalIconButtons({
    Key? key,
    this.title,
    this.icon,
    required this.iconsWithTitles,
  }) : super(key: key);

  final imageVideoPhotoService = ImageVideoPhotoService();

  handleItemClick(context, String title) {
    //FUNCAO QUE RETORNA PELO TITULO CONFIGURADO
    switch (title) {
      case 'Câmera':
        imageVideoPhotoService.takePhotoImage().then(
              (value) => {
                image = value.image,
                imagePath = value.imagePath,    
                selectedItem = 'Take Photo',            
                print('$image, $imagePath, 9999'),
                Navigator.pop(context, {'selectedItem': selectedItem, 'image':image, 'imagePath':imagePath})
              },
            );
        selectedItem = 'camera';
        break;
      case 'Imagem Galeria':
        imageVideoPhotoService.pickImageGalery().then(
              (value) => {
                image = value.image,
                imagePath = value.imagePath, 
                selectedItem = 'Galery Photo',               
                print('$image, $imagePath, 9999'),
                Navigator.pop(context, {'selectedItem': selectedItem, 'image':image, 'imagePath':imagePath})
              },
            );        
        break;
      case 'Vídeo':
        selectedItem = 'video';
        break;
      case 'delete':
        selectedItem = '';
        Navigator.pop(context, {'selectedItem': selectedItem});
        break;
      default:
        selectedItem = 'padrao';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(190),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(45),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                //PARTE DO TITULO GERAL
                Padding(
                  padding: const EdgeInsets.only(
                      top: 35, right: 35, left: 35, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title ?? '',
                          style: const TextStyle(
                            fontSize: 20, // Tamanho do título
                            fontWeight: FontWeight.bold, // Estilo do título
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          handleItemClick(context, 'delete');                          
                          // Faça algo quando o ícone for clicado
                          // Exemplo: Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconTheme(
                            data: const IconThemeData(
                              color: Colors.red, // Cor do ícone clicável
                              size: 24, // Tamanho do ícone
                            ),
                            child: Icon(icon),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //PARTE DOS ICONS
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: iconsWithTitles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final iconData = iconsWithTitles[index].key;
                      final iconTitle = iconsWithTitles[index].value;
                      return ListTile(
                        leading: Icon(iconData),
                        title: Row(
                          children: [
                            Text(iconTitle),
                            const Spacer(),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                        onTap: () async {
                          await handleItemClick(context, iconTitle);                       
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
