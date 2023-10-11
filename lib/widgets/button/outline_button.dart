import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/config/config_font.dart';
import 'package:unidy_mobile/utils/utils_font._builder.dart';

class OutlineButtonStyle extends ButtonStyle {
  final FontBuilder fontBuilder = FontBuilder(option: BodyRegular.fs16);

  @override
  MaterialStateProperty<OutlinedBorder?> get shape => MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: const BorderSide(color: PrimaryColor.primary500)
    )
  );


  @override
  MaterialStateProperty<TextStyle?> get textStyle => MaterialStatePropertyAll(
    fontBuilder.font
  );
}

class UnidyOutlineButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;

  const UnidyOutlineButton({ Key? key, required this.text, this.onPressed, this.height, this.width }) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlineButtonStyle(),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
