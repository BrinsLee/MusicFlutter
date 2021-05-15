
import 'package:flutter/material.dart';
import 'package:music_flutter/common/theme/theme.dart';

Map<String, ThemeData?> darkThemes = {
  "KDMaterial Dark" : kDarkTheme
};

class DarkThemeModel extends ChangeNotifier {
  ThemeData? currentTheme = kDarkTheme;

  DarkThemeModel(this.currentTheme, Color? accentColor) {
    changeAccent(accentColor);
  }

  void changeAccent(Color? accentColor) {
    ThemeData newTheme = currentTheme!;
    newTheme = newTheme.copyWith(errorColor: accentColor);
    currentTheme = newTheme;
    return notifyListeners();
  }

  int? getIndex(ThemeData? currentThemeData) {
    return darkThemes.values.toList().contains(currentThemeData)
        ? darkThemes.values.toList().indexOf(currentThemeData)
        : null;
  }

  String getTheme(ThemeData currentThemeData) {
    return darkThemes.keys.toList()[getIndex(currentThemeData) ?? 0];
  }

  void changeThemeByID(String themeID) {
    debugPrint(themeID);
    currentTheme = darkThemes[themeID];
    return notifyListeners();
  }
}