import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ProductionReceiptItemQtyNonBatchDialog extends StatefulWidget {
  final ProductionReceiptItemModel item;

  const ProductionReceiptItemQtyNonBatchDialog(this.item);

  @override
  _ProductionReceiptItemQtyNonBatchDialogState createState() =>
      _ProductionReceiptItemQtyNonBatchDialogState();
}

class _ProductionReceiptItemQtyNonBatchDialogState
    extends State<ProductionReceiptItemQtyNonBatchDialog> {
  final _quantity = TextEditingController();
  final _quantityReject = TextEditingController();

  ProductionReceiptItemModel get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    var openQty = widget.item.openQty == 0.0
        ? widget.item.openQty.toStringAsFixed(authProvider.decLen)
        : formatter.format(widget.item.openQty);
    return Container(
        padding: const EdgeInsets.all(kLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTitle('Input Item Quantity'),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('PO Quantity', openQty),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildQtyFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildQtyRejectFormField(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            //buildButtonSubmit(context),
            // if (((_quantity.text != '' || _quantityReject.text != '') ||
            //         (_quantity.text == '0' || _quantity.text == '0.0') ||
            //         (_quantityReject.text == '0' ||
            //             _quantityReject.text == '0.0')) &&
            //     (((_quantity.text.isEmpty
            //                 ? double.parse('0')
            //                 : double.parse(_quantity.text)) +
            //             (_quantityReject.text.isEmpty
            //                 ? double.parse('0')
            //                 : double.parse(_quantityReject.text))) >
            //         double.tryParse(widget.item.openQty.toStringAsFixed(4))))
            //   buildButtonNotif(context, openQty)
            // else
              buildButtonSubmit(context, openQty),
          ],
        ));
  }

  Widget buildQtyFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantity,
        textInputAction: TextInputAction.next,
        autofocus: true,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Complete Quantity',
          hintText: 'Input Complete Quantity',
        ),
      ),
    );
  }

  Widget buildQtyRejectFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantityReject,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Reject Quantity',
          hintText: 'Input Reject Quantity',
        ),
      ),
    );
  }

  Widget buildButtonSubmit(BuildContext context, String avlQty) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            if (((_quantity.text != '' || _quantityReject.text != '') ||
                    (_quantity.text == '0' || _quantity.text == '0.0') ||
                    (_quantityReject.text == '0' ||
                        _quantityReject.text == '0.0')) &&
                (((_quantity.text.isEmpty
                            ? double.parse('0')
                            : double.parse(_quantity.text)) +
                        (_quantityReject.text.isEmpty
                            ? double.parse('0')
                            : double.parse(_quantityReject.text))) >
                    double.tryParse(widget.item.openQty.toStringAsFixed(3)))) {
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
            final itemPoProvider = Provider.of<ProductionReceiptItemProvider>(
                context,
                listen: false);
            itemPoProvider.inputQty(
              item,
              double.parse(_quantity.text),
              double.parse(_quantityReject.text),
            );

            Navigator.of(context).pop();
          }),
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
}
