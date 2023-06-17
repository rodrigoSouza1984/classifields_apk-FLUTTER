import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/utils/format_date.dart';

import 'package:classifields_apk_flutter/src/controllers/user_controller.dart';

class InputComponent extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool readOnly;
  final bool isDate;
  final bool isSecret;
  final bool errorText; //aki
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  bool isObscure = false; //don't need receive by constructor

  InputComponent({
    Key? key,
    required this.icon,
    required this.label,
    this.readOnly = false,
    this.keyboardType,
    this.isDate = false,
    this.isSecret = false,
    this.errorText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  final UserController userController = UserController(); //aki
  List<dynamic>? nickNameValidator = []; //aki3
  bool emailExists= false;
  String errorText = '';

  final FormatDate formatDate = FormatDate();

  DateTime? _selectedDate;

  DateTime date = DateTime(2000, 01, 01);
  bool hasDate = false;

  bool isObscure = false;

  late FocusNode _focusNode;

  //funcao para selecionar data
  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();

    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
      hasDate = true;
      widget.controller?.text = formatDate.formatDate(date);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    isObscure = widget.isSecret;

    super.initState(); //aki
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override //aki
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() async {
    //aki add
    if (!_focusNode.hasFocus) {
      if (widget.label == 'NickName') {
        nickNameValidator =
            await userController.createUserNameUnique(widget.controller!.text);

        if (nickNameValidator?[0] != widget.controller!.text) {
          setState(() {
            errorText =
                'NickName já existe , \nsugestões: ${nickNameValidator?[0]} , \n${nickNameValidator?[1]} , ${nickNameValidator?[2]}';
          });
        } else {
          setState(() {
            errorText = '';
          });
        }
      }else if(widget.label == 'Email'){
        emailExists =
            await userController.verifyEmailExists(widget.controller!.text);

        if (emailExists == true) {
          setState(() {
            errorText =
                'Email já cadastrado escolha outro para seu registro';
          });
        } else {
          setState(() {
            errorText = '';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller,
        onTap: () async {
          if (widget.isDate != true) {
            return;
          } else {
            await selectDate(context);
          }
        },
        obscureText: isObscure,
        //keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        focusNode: _focusNode,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                      print(isObscure);
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          labelText: widget.label,
          errorText: widget.errorText && errorText != '' ? errorText : null,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
