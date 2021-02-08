import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpen_simpen/core/utils/utils.dart';

class UserProvider extends ChangeNotifier {
  String _name;
  bool _logedin = false;

  String get name => _name;

  set name(String value) {
    _name = value;
    Preferences.instance().then((val) {
      val.nama = value;
    });
    notifyListeners();
  }

  bool get logedin => _logedin;
  set logedin(bool value) {
    _logedin = value;
    notifyListeners();
  }

  void logout() {
    _logedin = false;
    name = null;
  }

  static UserProvider instance(BuildContext context) => Provider.of(context, listen: false);
}
