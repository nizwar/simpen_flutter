import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:simpen_simpen/core/models/database/simpenanDB.dart';
import 'package:simpen_simpen/core/models/simpenanDB.dart';
import 'package:simpen_simpen/core/providers/databaseProvider.dart';
import 'package:simpen_simpen/core/providers/userProvider.dart';
import 'package:simpen_simpen/core/utils/databaseEngine.dart';
import 'package:simpen_simpen/core/utils/utils.dart';

import 'addSimpenanScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIMPENAN"),
        actions: [
          FlatButton(
            child: Consumer<UserProvider>(
              builder: (context, value, child) => Text(
                value.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: _logout,
          )
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, value, child) => FutureBuilder<List<Simpenan>>(
          future: DatabaseEngine.initDB().then<List<Simpenan>>((value) => SimpenanDB(context, value).getAll()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData)
              return Center(
                child: Text("Belum ada data"),
              );
            return ListView(
              padding: EdgeInsets.only(bottom: 100),
              children: snapshot.data
                  .map(
                    (item) => Slidable(
                      key: Key(item.id.toString()),
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.orange,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          onTap: () {
                            startScreen(
                                context,
                                AddSimpenanScreen(
                                  simpenan: item,
                                ));
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            SimpenanDB(context, await DatabaseEngine.initDB()).delete(item.id);
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.type == 0 ? "Income" : "Outcome"),
                        trailing: Text("Rp" + NumberFormat("#,###").format(item.amount).replaceAll(",", ".")),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Consumer<DatabaseProvider>(
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder(
                      future: DatabaseEngine.initDB().then<int>((value) => SimpenanDB(context, value).totalIncome()),
                      builder: (context, snapshot) => Text(
                        "Total Income : " + "Rp" + NumberFormat("#,###").format(snapshot.hasData ? snapshot.data : 0).replaceAll(",", "."),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    FutureBuilder(
                      future: DatabaseEngine.initDB().then<int>((value) => SimpenanDB(context, value).totalOutcome()),
                      builder: (context, snapshot) => Text(
                        "Total Outcome : " + "Rp" + NumberFormat("#,###").format(snapshot.hasData ? snapshot.data : 0).replaceAll(",", "."),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: _addSimpenan,
            ),
          ],
        ),
      ),
    );
  }

  void _addSimpenan() {
    startScreen(context, AddSimpenanScreen());
  }

  void _logout() async {
    var resp = await NAlertDialog(
      title: Text("Mau Keluar?"),
      content: Text("Setelah keluar anda diharuskan login kembali"),
      dialogStyle: DialogStyle(animatePopup: false),
      actions: [
        FlatButton(
          child: Text("Keluar"),
          onPressed: () {
            closeScreen(context, true);
          },
        ),
        FlatButton(
          child: Text("Batal"),
          onPressed: () {
            closeScreen(context, false);
          },
        ),
      ],
    ).show(context);
    if (resp ?? false) {
      UserProvider.instance(context).logout();
    }
  }
}
