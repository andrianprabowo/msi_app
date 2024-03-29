import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/screens/production_pick_list_item/production_pick_list_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ProductionPickListItemNonBatchDialog extends StatefulWidget {
  final ProductionPickListItemModel item;

  const ProductionPickListItemNonBatchDialog(this.item);

  @override
  _ProductionPickListItemNonBatchDialogState createState() =>
      _ProductionPickListItemNonBatchDialogState();
}

class _ProductionPickListItemNonBatchDialogState
    extends State<ProductionPickListItemNonBatchDialog> {
  final _quantity = TextEditingController();

  ProductionPickListItemModel get item {
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
          BaseTitle('Input Quantity'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(item.itemStorageLocation),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(widget.item.itemCode),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(widget.item.description),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine(
              'Total to Pick Qty',
              widget.item.quantity == 0.0
                  ? widget.item.quantity.toStringAsFixed(authProvider.decLen)
                  : formatter.format(widget.item.quantity)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          // if (_quantity.text != '' &&
          //         (double.parse(_quantity.text) >
          //             double.tryParse(
          //                 widget.item.openQty.toStringAsFixed(4))) ||
          //     _quantity.text == '0')
          //   buildButtonNotif(context, openQty)
          // else
          buildButtonSubmit(context, openQty),
        ],
      ),
    );
  }

  Widget buildQtyFormField() {
    return SizedBox(
      width: getProportionateScreenWidth(280),
      child: TextFormField(
        keyboardType: TextInputType.number,
        autofocus: true,
        controller: _quantity,
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
          final pickItemReceiveProvider =
              Provider.of<ProductionPickListItemProvider>(context,
                  listen: false);
          pickItemReceiveProvider.updateQtyNBinNonBatch(
              item, double.parse(_quantity.text));
          if (double.parse(_quantity.text) > widget.item.quantity) {
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
                      BaseTitleColor('or equal to  ${widget.item.quantity}'),
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
          // Navigator.of(context)
          //     .pushNamed(ProductionPickListBin.routeName, arguments: item);
          // //  Navigator.of(context).pop();
          final prodItemReceiveProvider =
              Provider.of<ProductionPickListItemProvider>(context,
                  listen: false);
          prodItemReceiveProvider.updateQtyNBinNonBatch(
            item,
            double.parse(_quantity.text),
          );
          final batchList = ProductionPickListItemBatchModel(
              pickQty: item.pickedQty, bin: item.itemStorageLocation);

          print('test isinya 4 $batchList');

          pickItemReceiveProvider.addBin(item, batchList);

          Navigator.of(context)
              .popUntil(ModalRoute.withName(ProductionPickListItem.routeName));
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
