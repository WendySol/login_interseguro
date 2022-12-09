import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences? _prefs;

  Preferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs!.clear();
  }

  String? get user {
    return _prefs!.getString('name_user');
  }

  set user(String? value) {
    _prefs!.setString('name_user', value!);
  }

  bool? get rememberme {
    return _prefs!.getBool('rememeber_me');
  }

  set rememberme(bool? value) {
    _prefs!.setBool('rememeber_me', value!);
  }
}
