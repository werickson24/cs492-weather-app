import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  Color _themeColor = Colors.blue;

  SharedPreferences? prefs;

  bool get darkMode => _darkMode;

  Color get themeColor => _themeColor;

  void toggleMode() {
    _darkMode = !_darkMode;
    if (prefs != null) {
      prefs!.setBool('darkMode', _darkMode);
    }

    notifyListeners();
  }

  void updateColorTheme(Color color) async {
    _themeColor = color;
    if(prefs != null){
      prefs!.setString('themeColor', _themeColor.toHexString());
    }
    notifyListeners();
  }

  SettingsProvider() {
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _darkMode = prefs!.getBool('darkMode') ?? false;
      //_themeColor = Color(prefs!.getString('themeColor') ?? '0x000000');
    }
    notifyListeners();
  }
}
