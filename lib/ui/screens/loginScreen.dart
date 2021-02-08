import 'package:flutter/material.dart';
import 'package:simpen_simpen/core/providers/userProvider.dart';
import 'package:simpen_simpen/core/resources/myColors.dart';
import 'package:simpen_simpen/ui/components/customDivider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _etName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _etName,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              ColumnDivider(),
              SizedBox(
                height: 40,
                child: FlatButton(
                  onPressed: () => _loginClick(context),
                  color: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Masuk",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loginClick(BuildContext context) {
    UserProvider.instance(context)
      ..logedin = true
      ..name = _etName.text;
  }
}
