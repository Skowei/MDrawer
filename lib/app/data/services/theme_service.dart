import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';

class ThemeService {
  var box = Hive.box('theme');
  ThemeMode defaultTheme = ThemeMode.dark;

  ThemeMode getThemeMode() => isSavedDarkMode
      ? savedThemeMode
          ? ThemeMode.dark
          : ThemeMode.light
      : defaultTheme;

  bool get isSavedDarkMode => box.containsKey('isDarkMode');
  bool get savedThemeMode =>
      box.get('isDarkMode') ?? defaultTheme == ThemeMode.dark ? true : false;
  void saveThemeMode(bool isDarkMode) => box.put('isDarkMode', isDarkMode);

  void changeThemeMode() {
    Get.changeThemeMode(savedThemeMode ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!savedThemeMode);
  }
}
