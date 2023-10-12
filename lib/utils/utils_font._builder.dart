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
      color: option.color,
    );
  }

  void reset() {
    object = GoogleFonts.readexPro();
  }
  
  FontBuilder setColor(Color color) {
    object = object.copyWith(color: color);
    return this;
  }
  
  FontBuilder setFontSize(double size) {
    object = object.copyWith(fontSize: size);
    return this;
  }
  
  FontBuilder setWeight(FontWeight fontWeight) {
    object = object.copyWith(fontWeight: fontWeight);
    return this;
  }

  FontBuilder setLineHeight(double lineHeight) {
    object = object.copyWith(height: lineHeight);
    return this;
  }

  FontBuilder setLetterSpacing(double value) {
    object = object.copyWith(letterSpacing: value);
    return this;
  }
  
  TextStyle get font => object;
}
