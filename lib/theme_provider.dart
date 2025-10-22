import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Başlangıçta açık tema kullanılır
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Koyu tema mı kullanılıyor?
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Temayı değiştir (koyu -> açık, açık -> koyu)
  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners(); // Değişikliği bildirerek UI'ın güncellenmesini sağlar
  }
}