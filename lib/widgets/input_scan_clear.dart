import 'package:flutter/material.dart';

class InputScanClear extends StatefulWidget {
  final String label;
  final String hint;
  final String input;
  final void Function(String scanResult) scanResult;

  const InputScanClear({
    this.label,
    this.hint,
    this.input,
    this.scanResult,
  });

  @override
  _InputScanClearState createState() => _InputScanClearState();
}

class _InputScanClearState extends State<InputScanClear> {
  @override
  Widget build(BuildContext context) {
    final clearText = TextEditingController();
    return TextFormField(
      controller: clearText,
      onChanged: (value) {
        print('clear 01 $clearText');
        
        // print('clear 01 is $clearText');

        widget.scanResult(value);
        clearText.clear();
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: Icon(Icons.assessment_outlined),
      ),
      autofocus: true,
    );
  }
}
