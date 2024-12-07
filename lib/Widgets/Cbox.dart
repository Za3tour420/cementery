import 'package:flutter/material.dart';

class Cbox extends StatefulWidget {
  const Cbox({super.key});

  @override
  _CboxState createState() => _CboxState();
}

class _CboxState extends State<Cbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
        });
      },
    );
  }
}

