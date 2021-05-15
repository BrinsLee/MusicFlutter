import 'package:flutter/material.dart';
import 'package:music_flutter/common/theme/theme.dart';

Map<String, ThemeData?> themes = {
  "kLFrost White": kLightTheme,
};

class ThemeModel extends ChangeNotifier {
  ThemeData? currentTheme = kLightTheme;

  ThemeModel(this.currentTheme, Color? accentColor) {
    changeAccentColor(accentColor);
  }

  void changeAccentColor(Color? accentColor) {
    ThemeData newTheme = currentTheme!;
    newTheme = newTheme.copyWith(errorColor: accentColor);
    currentTheme = newTheme;
    return notifyListeners();
  }

  int? getIndex(ThemeData? currentThemeData) {
    return themes.values.toList().contains(currentThemeData)
        ? themes.values.toList().indexOf(currentThemeData)
        : null;
  }

  String getTheme(ThemeData currentThemeData) {
    return themes.keys.toList()[getIndex(currentThemeData) ?? 0];
  }

  void changeThemeById(String themeId) {
    currentTheme = themes[themeId];
    return notifyListeners();
  }
}
