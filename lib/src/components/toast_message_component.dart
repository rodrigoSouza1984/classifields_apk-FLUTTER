import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToastModal extends StatefulWidget {
  final String message;
  final Duration? duration;

  const ToastModal({Key? key, required this.message, required this.duration})
      : super(key: key);

  @override
  _ToastModalState createState() => _ToastModalState();
}

class _ToastModalState extends State<ToastModal> {
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    showOverlay();
    startTimer();
  }

  void showOverlay() {
    overlayEntry = OverlayEntry(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final modalWidth = screenWidth * 0.9; // 90% do tamanho da tela
        final padding = EdgeInsets.all(8.0); // Padding nos 4 lados do texto

        return Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          left: (screenWidth - modalWidth) / 2,
          width: modalWidth,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Padding interno do container
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        );
      },
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Overlay.of(context)!.insert(overlayEntry);
    });
  }

  void startTimer() async {
    await Future.delayed(widget.duration!);
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}