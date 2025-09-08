

import 'package:flutter/material.dart';

abstract final class UITheme {
  static final theme = getDarkTheme();

  static const defaultShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(),
          helperMaxLines: 2,
        ),
      ),
      iconTheme: IconThemeData(
        size: 16,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          enableFeedback: true,
          iconSize: WidgetStatePropertyAll(18)
        ),
      ),
      cardTheme: CardThemeData(
        shape: defaultShape,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          enableFeedback: true,
        ),
      ),
      splashFactory: InkSplash.splashFactory,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(),
        helperMaxLines: 2,
        contentPadding: EdgeInsets.all(8),
        labelStyle: TextStyle(
          fontSize: 14,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: defaultShape,
      ),
    );
  }

}