import 'package:flutter/material.dart';

class InputScan extends StatefulWidget {
  final String label;
  final String hint;
  final void Function(String scanResult) scanResult;

  const InputScan({
    this.label,
    this.hint,
    this.scanResult,
  });

  @override
  _InputScanState createState() => _InputScanState();
}

class _InputScanState extends State<InputScan> {
  @override
  Widget build(BuildContext context) {
  final _text = TextEditingController();

    return TextFormField(
      controller: _text,
      onChanged: (value) {
        widget.scanResult(value);
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: IconButton(
          icon: Icon(Icons.assessment_outlined),
          onPressed: () {
            _text.clear();
            print('delete');
          },
        ),
      ),
      autofocus: true,
    );
  }
}
