import 'package:flutter/material.dart';
import 'package:simpen_simpen/core/resources/myColors.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final Function(T value) onChanged;

  const CustomRadio({Key key, this.value, this.groupValue, this.title, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(value);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        color: value == groupValue ? primaryColor : Colors.grey.shade300,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: value == groupValue ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
