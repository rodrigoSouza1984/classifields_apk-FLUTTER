import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/config/color_config_apk.dart';

class User {
  final String name;
  final String avatarUrl;

  User({required this.name, required this.avatarUrl});
}

class UserListPage extends StatefulWidget {
  UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool editOrDeleteUsers = true;

  final List<User> users = [
    User(
        name: 'Usuário 1',
        avatarUrl:
            'https://storage.googleapis.com/classifields-a6331.appspot.com/classifields/users/11/avatar/2023-07-03T00%3A40%3A38.961170Z.jpeg?GoogleAccessId=firebase-adminsdk-7s7le%40classifields-a6331.iam.gserviceaccount.com&Expires=33235930800&Signature=H%2BNJxddtkS8KXNDUNPuYXLNRs0drxrJsRo43FQCQ%2FV%2B7mHmZoV8LVTZXqNGVsC0SjlcX2gg2EzGrGfL%2FratGM%2F7VQ6fcoXOqCaqS57H18xBt7mEBbn%2Bq4b6H0q01BRVmnjx%2FI23Ev12UVhLxWKG2lFQvf3HKocGifuSwGKyA4G3m%2Bxez9MZgcH7rhfMqjtb9LKE2Ggsm%2FqoVl2pgl3o9vs%2FM5AXNCRGPiTQP9YUw%2BFMUrGKy%2FKVo%2BjpeEorzqTVoxGgxIaEpQjmEjJjz60N99f1KMguNaRdImbfd%2Fw9717ukfE8GvNz9SNlQPOD41TobZCTNo9%2F0Od249hNC4x1Rcw%3D%3D'),
    User(
        name: 'Usuário 2',
        avatarUrl:
            'https://storage.googleapis.com/classifields-a6331.appspot.com/classifields/users/11/avatar/2023-07-03T00%3A40%3A38.961170Z.jpeg?GoogleAccessId=firebase-adminsdk-7s7le%40classifields-a6331.iam.gserviceaccount.com&Expires=33235930800&Signature=H%2BNJxddtkS8KXNDUNPuYXLNRs0drxrJsRo43FQCQ%2FV%2B7mHmZoV8LVTZXqNGVsC0SjlcX2gg2EzGrGfL%2FratGM%2F7VQ6fcoXOqCaqS57H18xBt7mEBbn%2Bq4b6H0q01BRVmnjx%2FI23Ev12UVhLxWKG2lFQvf3HKocGifuSwGKyA4G3m%2Bxez9MZgcH7rhfMqjtb9LKE2Ggsm%2FqoVl2pgl3o9vs%2FM5AXNCRGPiTQP9YUw%2BFMUrGKy%2FKVo%2BjpeEorzqTVoxGgxIaEpQjmEjJjz60N99f1KMguNaRdImbfd%2Fw9717ukfE8GvNz9SNlQPOD41TobZCTNo9%2F0Od249hNC4x1Rcw%3D%3D'),
    User(
        name: 'Usuário 3',
        avatarUrl:
            'https://storage.googleapis.com/classifields-a6331.appspot.com/classifields/users/11/avatar/2023-07-03T00%3A40%3A38.961170Z.jpeg?GoogleAccessId=firebase-adminsdk-7s7le%40classifields-a6331.iam.gserviceaccount.com&Expires=33235930800&Signature=H%2BNJxddtkS8KXNDUNPuYXLNRs0drxrJsRo43FQCQ%2FV%2B7mHmZoV8LVTZXqNGVsC0SjlcX2gg2EzGrGfL%2FratGM%2F7VQ6fcoXOqCaqS57H18xBt7mEBbn%2Bq4b6H0q01BRVmnjx%2FI23Ev12UVhLxWKG2lFQvf3HKocGifuSwGKyA4G3m%2Bxez9MZgcH7rhfMqjtb9LKE2Ggsm%2FqoVl2pgl3o9vs%2FM5AXNCRGPiTQP9YUw%2BFMUrGKy%2FKVo%2BjpeEorzqTVoxGgxIaEpQjmEjJjz60N99f1KMguNaRdImbfd%2Fw9717ukfE8GvNz9SNlQPOD41TobZCTNo9%2F0Od249hNC4x1Rcw%3D%3D'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Lista de Usuários'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.edit, size: 20.0),
              onPressed: () {
                // Ação quando o ícone de edição na AppBar for pressionado
              },
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            title: Text(user.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (editOrDeleteUsers)
                  IconButton(
                    icon: Icon(Icons.delete, size: 20.0, color: Colors.red),
                    onPressed: () {
                      // Ação quando o ícone de lixeira for pressionado
                    },
                  ),
                if (editOrDeleteUsers)
                  IconButton(
                    icon: Icon(Icons.edit, size: 20.0, color: Colors.blue),
                    onPressed: () {
                      // Ação quando o ícone de edição for pressionado
                    },
                  ),
                if (!editOrDeleteUsers)
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 20.0),
                    onPressed: () {
                      // Ação quando o ícone de seta for pressionado
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
