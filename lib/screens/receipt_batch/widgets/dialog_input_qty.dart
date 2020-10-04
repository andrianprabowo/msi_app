import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_po_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';

class DialogInputQty extends StatefulWidget {
  final ItemPoBatch item;

  const DialogInputQty(this.item);

  @override
  _DialogInputQtyState createState() => _DialogInputQtyState();
}

class _DialogInputQtyState extends State<DialogInputQty> {
  final _quantity = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  String get dateString {
    return DateFormat.yMMMMd().format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Batch Number / Exp Date'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildReadOnlyInput(widget.item.itemCode),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildDatePicker(context),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildButtonSubmit(),
        ],
      ),
    );
  }

  Widget buildReadOnlyInput(String value) {
    return TextFormField(
      readOnly: true,
      initialValue: value,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Item Barcode',
        hintText: 'Scan Item / Barcode',
        suffixIcon: Icon(Icons.local_see),
      ),
    );
  }

  Widget buildDatePicker(context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(kLarge),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: kTiny,
                  style: BorderStyle.solid,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(kMedium),
                ),
              ),
            ),
            child: Text(dateString),
          ),
        ),
        IconButton(
          icon: Icon(Icons.event),
          onPressed: () async {
            final maxYear = DateTime.now().year + 5;
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(maxYear),
            );

            if (pickedDate == null) return;

            setState(() {
              _selectedDate = pickedDate;
            });
          },
        ),
      ],
    );
  }

  Widget buildQtyFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantity,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Quantity',
          hintText: 'Input Quantity',
        ),
      ),
    );
  }

  Widget buildButtonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
