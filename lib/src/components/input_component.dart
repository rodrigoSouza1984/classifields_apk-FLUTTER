import 'package:flutter/material.dart';
import 'package:classifields_apk_flutter/src/utils/format_date.dart';

class InputComponent extends StatefulWidget {

  final IconData icon;
  final String label;
  final bool readOnly;  
  final bool isDate;
  final bool isSecret;  
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  bool isObscure = false;//don't need receive by constructor

  InputComponent({
    Key? key,
    required this.icon,				
    required this.label,
    this.readOnly = false,
    this.keyboardType, 
    this.isDate = false,   
    this.isSecret = false,		
    this.controller,
    this.validator,
    }) : super(key: key);

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {

  final FormatDate formatDate = FormatDate();

  DateTime? _selectedDate;

  DateTime date = DateTime(2000, 01, 01);
  bool hasDate = false;

  bool isObscure = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller, 			  
        onTap: () async {					
          if(widget.isDate != true){
            return;
          }else{
            await selectDate(context);
          }          
        },
        obscureText: isObscure,
        //keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
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
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
          ) : null,       	               
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18)
          ),
        ),
      ),
    );   
  }
}