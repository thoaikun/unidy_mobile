import 'dart:ui';

import 'package:unidy_mobile/config/color_config.dart';

class FontOption {
  final Color fontColor;
  final FontWeight fontWeight;

  Color get color => fontColor;
  FontWeight get weight => fontWeight;

  const FontOption(this.fontColor, this.fontWeight);
}

FontOption fontBold = const FontOption(TextColor.textColor900, FontWeight.w700);
FontOption fontSemiBold = const FontOption(TextColor.textColor900, FontWeight.w600);
FontOption fontMedium = const FontOption(TextColor.textColor900, FontWeight.w500);
FontOption fontRegular = const FontOption(TextColor.textColor900, FontWeight.w400);
FontOption fontLight = const FontOption(TextColor.textColor900, FontWeight.w300);