import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageVideoPhotoService {
  
  Future<dynamic> pickImageGalery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      // Caso nenhum imagem seja selecionada, retorne um objeto vazio
      return PickedImage(
        image: null,
        imagePath: null,
      );
    }

    // Caso uma imagem seja selecionada, retorne um objeto com a imagem e o caminho do arquivo
    return PickedImage(
      image: File(pickedImage.path),
      imagePath: pickedImage.path,
    );
  }

  Future<dynamic> takePhotoImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      // Caso nenhum imagem seja selecionada, retorne um objeto vazio
      return PickedImage(
        image: null,
        imagePath: null,
      );
    }

    // Caso uma imagem seja selecionada, retorne um objeto com a imagem e o caminho do arquivo
    return PickedImage(
      image: File(pickedImage.path),
      imagePath: pickedImage.path,
    );
  }
}

class PickedImage {
  final File? image;
  final String? imagePath; 

  PickedImage({required this.image, required this.imagePath});
}
