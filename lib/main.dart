import 'package:flutter/material.dart';
import 'package:simpen_simpen/core/providers/databaseProvider.dart';
import 'package:simpen_simpen/core/providers/userProvider.dart';
import 'package:simpen_simpen/core/utils/preferences.dart';
import 'package:simpen_simpen/ui/screens/loginScreen.dart';
import 'core/resources/myColors.dart';
import 'ui/screens/mainScreen.dart';
import 'package:provider/provider.dart';

main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
        ),
        home: Root(),
      ),
    ),
  );
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _ready = false;

  @override
  void initState() {
    Preferences.instance().then((val) async {
      await Future.delayed(Duration(seconds: 2));

      if (val.nama != null) {
        UserProvider.instance(context)
          ..logedin = true
          ..name = val.nama;
      }

      setState(() {
        _ready = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_ready ?? false)
        ? Consumer<UserProvider>(
            builder: (context, value, child) => value.logedin ? MainScreen() : LoginScreen(),
          )
        : SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Ini Splash"),
      ),
    );
  }
}
