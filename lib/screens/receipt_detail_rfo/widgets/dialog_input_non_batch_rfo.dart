import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/providers/item_po_provider_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class DialogInputQtyNonBatchRfo extends StatefulWidget {
  final ItemPurchaseOrderRfo item;

  const DialogInputQtyNonBatchRfo(this.item);

  @override
  _DialogInputQtyNonBatchRfoState createState() => _DialogInputQtyNonBatchRfoState();
}

class _DialogInputQtyNonBatchRfoState extends State<DialogInputQtyNonBatchRfo> {
  final _quantity = TextEditingController();

  ItemPurchaseOrderRfo get item {
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
          if (double.parse(_quantity.text) > widget.item.openQty) {
           
            print('Tidak boleh lebih besar dari Available Qty ');
            return;
          }
            final itemPoProvider =
                Provider.of<ItemPoRfoProvider>(context, listen: false);
            itemPoProvider.inputQty(
              item,
              double.parse(_quantity.text),
            );
            Navigator.of(context).pop();
          }),
    );
  }
}
