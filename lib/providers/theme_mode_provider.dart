import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  //ThemeModeProvider(this._themeModeService);

  bool _darkMode = false;

  bool get appMode => _darkMode;

  void toggleMode(){
    _darkMode = !_darkMode;
    notifyListeners();
  }

}