import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_batch_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMItemBatchDialog extends StatefulWidget {
  final ProductionReceiptRMItemListBatchListModel item;

  const ProductionReceiptRMItemBatchDialog(this.item);

  @override
  _ProductionReceiptRMItemBatchDialogState createState() =>
      _ProductionReceiptRMItemBatchDialogState();
}

class _ProductionReceiptRMItemBatchDialogState
    extends State<ProductionReceiptRMItemBatchDialog> {
  final _quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    var avlQty = widget.item.availableQty == 0.0
        ? widget.item.availableQty.toStringAsFixed(authProvider.decLen)
        : formatter.format(widget.item.availableQty);
    return Container(
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
          BaseTextLine('Available Quantity', avlQty),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          // if (_quantity.text != '' &&
          //         (double.tryParse(_quantity.text) >
          //             double.tryParse(
          //                 widget.item.availableQty.toStringAsFixed(4))) ||
          //     _quantity.text == '0')
          //   buildButtonNotif(context, avlQty)
          // else
            buildButtonSubmit(context, avlQty),
        ],
      ),
    );
  }

  Widget buildQtyFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantity,
        autofocus: true,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Quantity',
          hintText: 'Input Quantity',
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
           final stagingBin =
              Provider.of<ProductionReceiptRMItemListProvider>(context, listen: false);

          final itemList = stagingBin.items;
          double sisanya = 0;
          double list = 0;

          itemList.forEach((item) {
            if (item.itemCode == stagingBin.selected.itemCode) {
              double sisa = 0;
              double sisaSekarang = 0;
              double total = 0;
              print('test bismillah${item.pickedQty}');
              print('item ${item.itemCode}');
              print('item name ${item.description}');

              item.batchList.forEach((element) {
                print('breakk');

                if (element.batchNo == widget.item.batchNo) {
                  list = 1;
                  sisa = element.availableQty.toDouble() - item.pickedQty;
                  sisaSekarang = sisa - double.parse(_quantity.text);
                  total = total + element.pickQty;
                  print(' batch ${element.batchNo}');
                  print(' qty ${element.pickQty}');
                  print(' total $total');
                  int alert = 0;
                  sisanya = element.availableQty.toDouble() - total;
                  print(' sisnya $sisanya');

                  // if (double.parse(_quantity.text) > sisa) {
                  if (double.parse(_quantity.text) > sisanya) {
                    print(' error nih $sisa');
                    
                  }
                }
              });
            }
          });

          //
          if (list == 0) {
            sisanya = widget.item.availableQty;
          }
          if (double.parse(_quantity.text) > sisanya) {
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
                      BaseTitleColor('$sisanya qty left'),
                      SizedBox(height: getProportionateScreenHeight(kLarge)),
                      BaseTitleColor('on ${widget.item.batchNo}'),
                      SizedBox(height: getProportionateScreenHeight(kLarge)),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('OK'),
                          onPressed: () {
                            list = 0;
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
          double qty;
          try {
            qty = double.parse(_quantity.text);
          } on FormatException {
            // return;
          }

          Provider.of<ProductionReceiptRMItemListBatchListProvider>(context,
                  listen: false)
              .updatePickQty(widget.item.batchNo, qty);

          Navigator.of(context).pop();
        },
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
}
