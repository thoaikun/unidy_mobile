import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_font.dart';
import 'package:unidy_mobile/utils/utils_font._builder.dart';
import 'config_color.dart';

ColorScheme unidyColorScheme = ColorScheme.fromSeed(seedColor: PrimaryColor.primary500).copyWith(
  primary: PrimaryColor.primary500,
  onBackground: TextColor.textColor900,
);

TextTheme unidyTextTheme = TextTheme(
  displayLarge: FontBuilder(option: fontRegular).setFontSize(57).setLineHeight(64/57).setLetterSpacing(0).font,
  displayMedium: FontBuilder(option: fontRegular).setFontSize(45).setLineHeight(52/45).setLetterSpacing(0).font,
  displaySmall: FontBuilder(option: fontRegular).setFontSize(36).setLineHeight(40/32).setLetterSpacing(0).font,
  headlineLarge: FontBuilder(option: fontRegular).setFontSize(32).setLineHeight(40/32).setLetterSpacing(0).font,
  headlineMedium: FontBuilder(option: fontRegular).setFontSize(28).setLineHeight(36/28).setLetterSpacing(0).font,
  headlineSmall: FontBuilder(option: fontRegular).setFontSize(24).setLineHeight(32/24).setLetterSpacing(0).font,
  titleLarge: FontBuilder(option: fontMedium).setFontSize(22).setLineHeight(28/22).setLetterSpacing(0).font,
  titleMedium: FontBuilder(option: fontMedium).setFontSize(16).setLineHeight(24/16).setLetterSpacing(0.15).font,
  titleSmall: FontBuilder(option: fontMedium).setFontSize(14).setLineHeight(20/14).setLetterSpacing(0.1).font,
  labelLarge: FontBuilder(option: fontMedium).setFontSize(14).setLineHeight(20/14).setLetterSpacing(0.1).font,
  labelMedium: FontBuilder(option: fontMedium).setFontSize(12).setLineHeight(16/12).setLetterSpacing(0.5).font,
  labelSmall: FontBuilder(option: fontMedium).setFontSize(11).setLineHeight(16/11).setLetterSpacing(0.5).font,
  bodyLarge: FontBuilder(option: fontRegular).setFontSize(16).setLineHeight(24/16).setLetterSpacing(0.15).font,
  bodyMedium: FontBuilder(option: fontRegular).setFontSize(14).setLineHeight(20/14).setLetterSpacing(0.25).font,
  bodySmall: FontBuilder(option: fontRegular).setFontSize(12).setLineHeight(16/12).setLetterSpacing(0.4).font
);

FilledButtonThemeData unidyFilledButtonThemeData = FilledButtonThemeData(
  style: ButtonStyle(
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
          )
      )
  )
);

OutlinedButtonThemeData unidyOutlinedButtonThemeData = OutlinedButtonThemeData(
  style: ButtonStyle(
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          )
      )
  )
);

TextButtonThemeData unidyTextButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          )
      )
  )
);

ThemeData unidyThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: unidyColorScheme,
  textTheme: unidyTextTheme,
  filledButtonTheme: unidyFilledButtonThemeData,
  outlinedButtonTheme: unidyOutlinedButtonThemeData,
  textButtonTheme: unidyTextButtonThemeData,
);