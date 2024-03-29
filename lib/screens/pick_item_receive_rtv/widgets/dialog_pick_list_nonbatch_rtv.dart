import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_item_receive_rtv_provider.dart';
import 'package:msi_app/screens/pick_item_receive_rtv/pick_item_receive_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class DialogPickListNonbatchRtv extends StatefulWidget {
  final PickItemReceiveRtv item;

  const DialogPickListNonbatchRtv(this.item);

  @override
  _DialogPickListNonbatchRtvState createState() =>
      _DialogPickListNonbatchRtvState();
}

class _DialogPickListNonbatchRtvState extends State<DialogPickListNonbatchRtv> {
  final _quantity = TextEditingController();

  PickItemReceiveRtv get item {
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
          BaseTitle(item.itemStorageLocation),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(item.itemCode),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(item.description),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine(
              'Total to Pick Qty',
              widget.item.quantity == 0.0
                  ? widget.item.quantity.toStringAsFixed(authProvider.decLen)
                  : formatter.format(widget.item.quantity)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
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
          final pickItemReceiveProvider =
              Provider.of<PickItemReceiveRtvProvider>(context, listen: false);
          pickItemReceiveProvider.inputQtyNonBatch(
            item,
            double.parse(_quantity.text),
          );
          final batchList = PickBatchRtv(
              pickQty: item.pickedQty, bin: item.itemStorageLocation);

          print('test isinya 4 $batchList');

          pickItemReceiveProvider.addBin(item, batchList);

          Navigator.of(context).popUntil(
              ModalRoute.withName(PickItemReceiveRtvScreen.routeName));
        },
      ),
    );
  }
}
