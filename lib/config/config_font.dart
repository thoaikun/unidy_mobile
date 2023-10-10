import 'dart:ui';

import 'package:unidy_mobile/config/config_color.dart';

class FontOption {
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;

  Color get color => fontColor;
  double get size => fontSize;
  FontWeight get weight => fontWeight;

  const FontOption(this.fontColor, this.fontSize, this.fontWeight); 
}

class Heading1 {
  static const FontOption bold = FontOption(TextColor.textColor900, 38, FontWeight.w700);
  static const FontOption semiBold = FontOption(TextColor.textColor900, 38, FontWeight.w600);
  static const FontOption medium = FontOption(TextColor.textColor900, 38, FontWeight.w500);
  static const FontOption regular = FontOption(TextColor.textColor900, 38, FontWeight.w400);
}

class Heading2 {
  static const FontOption bold = FontOption(TextColor.textColor900, 32, FontWeight.w700);
  static const FontOption semiBold = FontOption(TextColor.textColor900, 32, FontWeight.w600);
  static const FontOption medium = FontOption(TextColor.textColor900, 32, FontWeight.w500);
  static const FontOption regular = FontOption(TextColor.textColor900, 32, FontWeight.w400);
}

class Heading3 {
  static const FontOption bold = FontOption(TextColor.textColor900, 24, FontWeight.w700);
  static const FontOption semiBold = FontOption(TextColor.textColor900, 24, FontWeight.w600);
  static const FontOption medium = FontOption(TextColor.textColor900, 24, FontWeight.w500);
  static const FontOption regular = FontOption(TextColor.textColor900, 24, FontWeight.w400);
}

class Heading4 {
  static const FontOption bold = FontOption(TextColor.textColor900, 20, FontWeight.w700);
  static const FontOption semiBold = FontOption(TextColor.textColor900, 20, FontWeight.w600);
  static const FontOption medium = FontOption(TextColor.textColor900, 20, FontWeight.w500);
  static const FontOption regular = FontOption(TextColor.textColor900, 20, FontWeight.w400);
}

class Heading5 {
  static const FontOption bold = FontOption(TextColor.textColor900, 18, FontWeight.w700);
  static const FontOption semiBold = FontOption(TextColor.textColor900, 18, FontWeight.w600);
  static const FontOption medium = FontOption(TextColor.textColor900, 18, FontWeight.w500);
  static const FontOption regular = FontOption(TextColor.textColor900, 18, FontWeight.w400);
}

class Heading6 {
  static const FontOption bold = FontOption(TextColor.textColor900, 16, FontWeight.w700);
  static const FontOption semiBold = FontOption(TextColor.textColor900, 16, FontWeight.w600);
  static const FontOption medium = FontOption(TextColor.textColor900, 16, FontWeight.w500);
  static const FontOption regular = FontOption(TextColor.textColor900, 16, FontWeight.w400);
}

class BodyBold {
  static const FontOption fs16 = FontOption(TextColor.textColor900, 16, FontWeight.w700);
  static const FontOption fs14 = FontOption(TextColor.textColor900, 14, FontWeight.w700);
  static const FontOption fs12 = FontOption(TextColor.textColor900, 12, FontWeight.w700);
  static const FontOption fs10 = FontOption(TextColor.textColor900, 10, FontWeight.w700);
}

class BodySemiBold {
  static const FontOption fs16 = FontOption(TextColor.textColor900, 16, FontWeight.w600);
  static const FontOption fs14 = FontOption(TextColor.textColor900, 14, FontWeight.w600);
  static const FontOption fs12 = FontOption(TextColor.textColor900, 12, FontWeight.w600);
  static const FontOption fs10 = FontOption(TextColor.textColor900, 10, FontWeight.w600);
}

class BodyMedium {
  static const FontOption fs16 = FontOption(TextColor.textColor900, 16, FontWeight.w500);
  static const FontOption fs14 = FontOption(TextColor.textColor900, 14, FontWeight.w500);
  static const FontOption fs12 = FontOption(TextColor.textColor900, 12, FontWeight.w500);
  static const FontOption fs10 = FontOption(TextColor.textColor900, 10, FontWeight.w500);
}


class BodyRegular {
  static const FontOption fs16 = FontOption(TextColor.textColor900, 16, FontWeight.w400);
  static const FontOption fs14 = FontOption(TextColor.textColor900, 14, FontWeight.w400);
  static const FontOption fs12 = FontOption(TextColor.textColor900, 12, FontWeight.w400);
  static const FontOption fs10 = FontOption(TextColor.textColor900, 10, FontWeight.w400);
}


class BodyLight {
  static const FontOption fs16 = FontOption(TextColor.textColor900, 16, FontWeight.w300);
  static const FontOption fs14 = FontOption(TextColor.textColor900, 14, FontWeight.w300);
  static const FontOption fs12 = FontOption(TextColor.textColor900, 12, FontWeight.w300);
  static const FontOption fs10 = FontOption(TextColor.textColor900, 10, FontWeight.w300);
}