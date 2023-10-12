import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/config/config_font.dart';
import 'package:unidy_mobile/utils/utils_font._builder.dart';

class UnidyFilledTonalButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;

  const UnidyFilledTonalButton({ Key? key, required this.text, this.onPressed, this.height, this.width }) : super(key: key);

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      textStyle: MaterialStatePropertyAll(FontBuilder(option: BodyRegular.fs16).font),
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return PrimaryColor.primary400;
          }
          return PrimaryColor.primary100;
        }
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        )
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton.tonal(
        style: getButtonStyle(),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}