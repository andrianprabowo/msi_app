import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/providers/item_po_provider_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class DialogInputQtyNonBatchRfo extends StatefulWidget {
  final ItemPurchaseOrderRfo item;

  const DialogInputQtyNonBatchRfo(this.item);

  @override
  _DialogInputQtyNonBatchRfoState createState() =>
      _DialogInputQtyNonBatchRfoState();
}

class _DialogInputQtyNonBatchRfoState extends State<DialogInputQtyNonBatchRfo> {
  final _quantity = TextEditingController();

  ItemPurchaseOrderRfo get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');

    return Container(
        padding: const EdgeInsets.all(kLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTitle(item.itemCode),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTitle(item.description),
            // SizedBox(height: getProportionateScreenHeight(kLarge)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('PO Qty', 
              item.openQty == 0.0
                  ? item.openQty.toStringAsFixed(4)
                  : formatter.format(item.openQty)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildQtyFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            // if (_quantity.text != '' &&
            //         (double.parse(_quantity.text) >
            //             double.tryParse(
            //                 widget.item.openQty.toStringAsFixed(2))) ||
            //     _quantity.text == '0')
            //   buildButtonNotif(context, widget.item.openQty.toString())
            // else
            buildButtonSubmit(context, formatter.format(widget.item.openQty)),
          ],
        ));
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
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Quantity',
          hintText: 'Input Quantity',
        ),
        autofocus: true,
      ),
    );
  }

  Widget buildButtonSubmit(BuildContext context, String avlQty) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            if (double.parse(_quantity.text) > widget.item.openQty) {
              print('Tidak boleh lebih besar dari Available Qty ');
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.notification_important,
                            color: Colors.red, size: 50),
                        Divider(),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        BaseTitleColor('Qty must be above 0'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        BaseTitleColor('or equal to  $avlQty'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
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
