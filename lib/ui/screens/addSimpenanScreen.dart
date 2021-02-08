import 'package:flutter/material.dart';
import 'package:simpen_simpen/core/models/database/simpenanDB.dart';
import 'package:simpen_simpen/core/models/simpenanDB.dart';
import 'package:simpen_simpen/core/resources/myColors.dart';
import 'package:simpen_simpen/core/utils/databaseEngine.dart';
import 'package:simpen_simpen/core/utils/utils.dart';
import 'package:simpen_simpen/ui/components/customDivider.dart';
import 'package:simpen_simpen/ui/components/customRadio.dart';

class AddSimpenanScreen extends StatefulWidget {
  final Simpenan simpenan;

  const AddSimpenanScreen({Key key, this.simpenan}) : super(key: key);
  @override
  _AddSimpenanScreenState createState() => _AddSimpenanScreenState();
}

class _AddSimpenanScreenState extends State<AddSimpenanScreen> {
  final TextEditingController _etTitle = TextEditingController();
  final TextEditingController _etCategory = TextEditingController();
  final TextEditingController _etAmount = TextEditingController();

  final FocusNode _fcTitle = FocusNode();
  final FocusNode _fcCategory = FocusNode();
  final FocusNode _fcAmount = FocusNode();

  int _type = 0;
  int _idToStore;

  @override
  void initState() {
    _idToStore = widget?.simpenan?.id;
    _etTitle.text = widget.simpenan?.title;
    _etCategory.text = widget.simpenan?.category;
    _etAmount.text = widget.simpenan?.amount?.toString();
    _type = widget.simpenan?.type ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    _fcTitle.dispose();
    _fcCategory.dispose();
    _fcAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Simpenan"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: _etTitle,
            focusNode: _fcTitle,
            onSubmitted: (val) {
              FocusScope.of(context).unfocus();
              _fcCategory.requestFocus();
            },
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Title"),
          ),
          ColumnDivider(),
          TextField(
            controller: _etCategory,
            focusNode: _fcCategory,
            onSubmitted: (val) {
              FocusScope.of(context).unfocus();
              _fcAmount.requestFocus();
            },
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Category"),
          ),
          ColumnDivider(),
          TextField(
            controller: _etAmount,
            focusNode: _fcAmount,
            onSubmitted: (val) {
              FocusScope.of(context).unfocus();
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Amount"),
          ),
          ColumnDivider(),
          Row(
            children: [
              Expanded(
                child: CustomRadio(
                  groupValue: _type,
                  value: 0,
                  title: "Income",
                  onChanged: (val) {
                    setState(() {
                      _type = val;
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomRadio(
                  groupValue: _type,
                  value: 1,
                  title: "Outcome",
                  onChanged: (val) {
                    setState(() {
                      _type = val;
                    });
                  },
                ),
              ),
            ],
          ),
          ColumnDivider(),
          FlatButton(
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            color: primaryColor,
            onPressed: _submit,
          )
        ],
      ),
    );
  }

  void _submit() async {
    if (_idToStore != null)
      await SimpenanDB(context, await DatabaseEngine.initDB()).update(
          widget.simpenan.id,
          Simpenan(
            amount: int.tryParse(_etAmount.text) ?? 0,
            title: _etTitle.text,
            category: _etCategory.text,
            type: _type,
          ));
    else
      await SimpenanDB(context, await DatabaseEngine.initDB()).insert(Simpenan(
        amount: int.tryParse(_etAmount.text) ?? 0,
        title: _etTitle.text,
        category: _etCategory.text,
        type: _type,
      ));

    closeScreen(context);
  }
}
