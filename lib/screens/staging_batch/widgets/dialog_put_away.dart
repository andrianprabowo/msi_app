import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/providers/item_batch_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class DialogPutAway extends StatefulWidget {
  final PutBatch item;

  const DialogPutAway(this.item);

  @override
  _DialogPutAwayState createState() => _DialogPutAwayState();
}

class _DialogPutAwayState extends State<DialogPutAway> {
  final _quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Input Batch Quantity'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine('Batch Number', widget.item.batchNo),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine('Expired Date', convertDate(widget.item.expiredDate)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine('Available Quantity',
              widget.item.availableQty.toStringAsFixed(2)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          if (_quantity.text != '' &&
                    (double.parse(_quantity.text) >
                        double.tryParse(
                            widget.item.availableQty.toStringAsFixed(2))) ||
                _quantity.text == '0')
              buildButtonNotif(context, widget.item.availableQty.toString())
            else
          buildButtonSubmit(context),
        ],
      ),
    );
  }

 Widget buildButtonNotif(BuildContext context, String avlQty) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.red,
        child: Text('Qty must be above 0 or equal to ' + avlQty),
        onPressed: () {},
      ),
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
        autofocus: true,
      ),
    );
  }

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          // handle if input not double to return nothing

          if (double.parse(_quantity.text) > widget.item.availableQty) {
            print('Tidak boleh lebih besar dari Available Qty ');
            return;
          }
          double qty;
          try {
            qty = double.parse(_quantity.text);
          } on FormatException {
            return;
          }

          Provider.of<ItemBatchProvider>(context, listen: false)
              .updatePickQty(widget.item.batchNo, qty);

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
