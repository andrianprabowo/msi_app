import 'package:flutter/material.dart';

class InputScan extends StatefulWidget {
  @override
  _InputScanState createState() => _InputScanState();
}

class _InputScanState extends State<InputScan> {
  final _scanInput = TextEditingController();
  String barcode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _scanInput,
            onChanged: (value) {
              barcode = value;
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Item Barcode',
              hintText: 'Scan Item / Barcode',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.local_see),
          onPressed: () {
            _scanInput.text = 'Item Code 0001';
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
