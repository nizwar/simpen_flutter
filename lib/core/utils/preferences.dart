import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences shared;

  Preferences(this.shared);

  String get nama => shared.getString("name");
  set nama(String value) {
    if (value == null) {
      shared.clear();
      return;
    }
    shared.setString("name", value);
  }

  static Future<Preferences> instance() => SharedPreferences.getInstance().then((value) => Preferences(value));
}
