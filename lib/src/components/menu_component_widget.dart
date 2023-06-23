import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/controllers/sign_in_controller.dart';

class MenuComponentWidget extends StatefulWidget {
  final Function(String) onItemSelected;

  const MenuComponentWidget({required this.onItemSelected});

  @override
  _MenuComponentWidgetState createState() => _MenuComponentWidgetState();
}

class _MenuComponentWidgetState extends State<MenuComponentWidget> {
  final ValueNotifier<String?> _selectedValue = ValueNotifier<String?>(null);
  final SignInController authController = SignInController();

  List<String> menuItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Defina a largura desejada para o Drawer
      child: Drawer(
        backgroundColor: Colors.white.withAlpha(230),        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(                                  
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 10, right: 16),//EdgeInsets.symmetric(horizontal: 16), // ajusta a posicao lateral dos itens
              child: ListView.builder(   
                shrinkWrap: true,                 
                itemCount: menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(menuItems[index]),
                    leading: const Icon(Icons.menu),
                    onTap: () {
                      _handleItemSelected(menuItems[index]);
                      Navigator.pop(context); // Fechar o menu após a seleção
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemSelected(String value) {
    _selectedValue.value = value;
    if (value == 'Logout') {
      authController.logout().then((value) {
        // Lógica de logout
      });
    } else if (value == 'Item 1') {
      print('Item 1 clicado');
    } else if (value == 'Item 2') {
      print('Item 2 clicado');
    } else if (value == 'Item 3') {
      print('Item 3 clicado');
    }
    widget.onItemSelected(value);
  }

  @override
  void dispose() {
    _selectedValue.dispose();
    super.dispose();
  }
}