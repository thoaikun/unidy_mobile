import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unidy_mobile/config/config_font.dart';

class FontBuilder {
  TextStyle object = GoogleFonts.readexPro();
  FontOption option;

  FontBuilder({required this.option}) {
    object = GoogleFonts.readexPro(
      fontWeight: option.fontWeight,
      fontSize: option.fontSize,
      color: option.color
    );
  }

  void reset() {
    object = GoogleFonts.readexPro();
  }
  
  void setColor(Color color) {
    object = object.copyWith(color: color);
  }
  
  void setFontSize(double size) {
    object = object.copyWith(fontSize: size);
  }
  
  void setWeight(FontWeight fontWeight) {
    object = object.copyWith(fontWeight: fontWeight);
  }

  void setLineHeight(double lineHeight) {
    object = object.copyWith(height: lineHeight);
  }
  
  TextStyle get font => object;
}
