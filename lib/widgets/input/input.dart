import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_color.dart';

enum InputType {
  text,
  password
}

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final InputType type;
  final Icon? icon;
  final String label;
  final String? placeholder;
  final String value = '';
  final bool numberKeyboard;
  final bool autoFocus;
  final bool readOnly;
  final bool enableBorder;

  const Input({ 
    Key? key, 
    this.controller,
    this.type = InputType.text,
    this.icon, 
    required this.label, 
    this.placeholder, 
    this.numberKeyboard = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.enableBorder = false
  }) : super(key: key);

  InputDecoration getInputDecoration() {
    return InputDecoration(
      labelText: label,

      hintText: placeholder,
      
      prefixIcon: icon,
      prefixIconColor: MaterialStateColor.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return PrimaryColor.primary500;
          }
          return TextColor.textColor300;
        }
      ),

      enabledBorder: enableBorder ? OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: TextColor.textColor200,
          width: 1.5,
          style: BorderStyle.solid
        )
      ) : null,
      focusedBorder: enableBorder ? OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: PrimaryColor.primary500,
          width: 1.5,
          style: BorderStyle.solid
        )
      ) : null
    );
  }

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      decoration: getInputDecoration(),
      keyboardType: numberKeyboard ? TextInputType.number : TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      autofocus: autoFocus,
      readOnly: readOnly,
      obscureText: type == InputType.password,
    );
  }
}