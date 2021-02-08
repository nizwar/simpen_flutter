import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatabaseProvider extends ChangeNotifier {
  void notify() => notifyListeners();

  static DatabaseProvider instance(BuildContext context) => Provider.of(context, listen: false);
}
