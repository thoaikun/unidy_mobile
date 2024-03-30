import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/config/themes/theme_config.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final String? placeholder;
  final String? error;
  final bool numberKeyboard;
  final bool autoFocus;
  final bool readOnly;
  final bool enableBorder;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;


  const Input({ 
    Key? key, 
    this.controller,
    this.focusNode,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    required this.label, 
    this.placeholder,
    this.error,
    this.numberKeyboard = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.enableBorder = false,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted
  }) : super(key: key);

  InputDecoration getInputDecoration() {
    return InputDecoration(
      labelText: label,
      errorText: error,
      hintText: placeholder,
      
      prefixIcon: prefixIcon,
      prefixIconColor: MaterialStateColor.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return PrimaryColor.primary500;
          }
          if (states.contains(MaterialState.error)) {
            return unidyColorScheme.error;
          }
          return TextColor.textColor300;
        }
      ),

      suffixIcon: suffixIcon,

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
      focusNode: focusNode,
      decoration: getInputDecoration(),
      keyboardType: numberKeyboard ? TextInputType.number : TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      autofocus: autoFocus,
      readOnly: readOnly,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  Widget dropdown<String>(BuildContext context, List<String> items, void Function(String?)? onSelected) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 40,
      label: Text(label),
      leadingIcon: prefixIcon,
      initialSelection: items[0],
      dropdownMenuEntries: items.map((String item) => DropdownMenuEntry<String>(
        value: item,
        label: '$item',
      )).toList(),
      onSelected: onSelected,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: null,
      ),
    );
  }

  Widget textarea() {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: getInputDecoration(),
      minLines: 1,
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }
}