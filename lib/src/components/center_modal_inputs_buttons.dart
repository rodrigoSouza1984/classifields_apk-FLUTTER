import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/components/toast_message_component.dart';

class CustomModal extends StatefulWidget {
  final String title;
  final List<Widget> inputs;
  final List<ButtonConfig> buttons;
  final Function(String)? returnModalForgetPassword;
  final BuildContext context;

  CustomModal({
    required this.title,
    required this.inputs,
    required this.buttons,
    this.returnModalForgetPassword,
    required this.context,
  });

  @override
  _CustomModalState createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  String _email = '';

  void showMyToast(BuildContext context, String message, Duration duration) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastModal(
        message: message,
        duration: duration,
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(widget.context).size.width;
    final modalWidth = screenWidth * 0.8;
    final double titlePadding = 10.0;
    final double messagePadding = 10.0;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: modalWidth,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Título
            Padding(
              padding: EdgeInsets.all(titlePadding),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Inputs
                  for (var input in widget.inputs) input,
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var button in widget.buttons)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () => _onButtonPressed(context, button.name),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: button.color,
                      ),
                      child: Text(button.name),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String name) {
    if (name == 'OK') {
      if (_formKey.currentState!.validate()) {
        // Executa a lógica para o botão OK
        if (widget.returnModalForgetPassword != null) {
          widget.returnModalForgetPassword!(_email);
        }

        //Navigator.pop(context);
      }
    } else if (name == 'Cancelar') {
      // Executa a lógica para o botão Cancelar
      Navigator.pop(context);
    }
  }
}

class ButtonConfig {
  final String name;
  final Color color;

  ButtonConfig({required this.name, required this.color});
}