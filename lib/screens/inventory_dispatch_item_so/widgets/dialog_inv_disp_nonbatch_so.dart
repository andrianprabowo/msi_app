import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_dispatch_item_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_so_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class DialogInvDispNonbatchSo extends StatefulWidget {
  final InventoryDispatchItemSo item;

  const DialogInvDispNonbatchSo(this.item);

  @override
  _DialogInvDispNonbatchSoState createState() =>
      _DialogInvDispNonbatchSoState();
}

class _DialogInvDispNonbatchSoState extends State<DialogInvDispNonbatchSo> {
  final _quantity = TextEditingController();

  InventoryDispatchItemSo get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
 final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Input Quantity'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(widget.item.itemCode),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(widget.item.description),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine(
              'Available Quantity',
              widget.item.openQty == 0.0
                  ? widget.item.openQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(widget.item.openQty)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          // if (_quantity.text != '' &&
          //         (double.parse(_quantity.text) >
          //             double.tryParse(
          //                 widget.item.openQty.toStringAsFixed(4))) ||
          //     _quantity.text == '0')
          //   buildButtonNotif(context, widget.item.openQty.toString())
          // else
          buildButtonSubmit(context, formatter.format(widget.item.openQty)),
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
          final inventoryDispatchItem =
              Provider.of<InventoryDispatchItemSoProvider>(context,
                  listen: false);
          inventoryDispatchItem.inputQtyNonBatch(
              item, double.parse(_quantity.text));
          //  Navigator.of(context)
          // .pushNamed(InventoryDispatchBinSoScreen.routeName, arguments: item);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
