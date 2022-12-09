import 'package:flutter/material.dart';

class RememberMeProvider with ChangeNotifier {
  bool _rememberme = false;

  bool get rememberme => _rememberme;

  //cambiar estado
  changeState(bool rememberme) {
    _rememberme = rememberme;
    notifyListeners();
  }
}
