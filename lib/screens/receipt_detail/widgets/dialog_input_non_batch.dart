import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/providers/item_po_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class DialogInputQtyNonBatch extends StatefulWidget {
  final ItemPurchaseOrder item;

  const DialogInputQtyNonBatch(this.item);

  @override
  _DialogInputQtyNonBatchState createState() => _DialogInputQtyNonBatchState();
}

class _DialogInputQtyNonBatchState extends State<DialogInputQtyNonBatch> {
  final _quantity = TextEditingController();

  ItemPurchaseOrder get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTitle('Input Item Quantity'),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildQtyFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildButtonSubmit(context),
          ],
        ));
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

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            final itemPoProvider =
                Provider.of<ItemPoProvider>(context, listen: false);
            itemPoProvider.inputQty(
              item,
              double.parse(_quantity.text),
            );
            Navigator.of(context).pop();
          }),
    );
  }
}
