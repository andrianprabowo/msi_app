import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/providers/pick_item_receive_rtv_provider.dart';
import 'package:msi_app/screens/pick_item_bin_rtv/pick_list_bin_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Input Quantity'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine(
              'Available Quantity', widget.item.openQty.toStringAsFixed(4)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          if (_quantity.text != '' &&
                  (double.parse(_quantity.text) >
                      double.tryParse(
                          widget.item.openQty.toStringAsFixed(4))) ||
              _quantity.text == '0')
            buildButtonNotif(context, widget.item.openQty.toStringAsFixed(4))
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
          if (double.parse(_quantity.text) > widget.item.openQty) {
            print('Tidak boleh lebih besar dari Available Qty ');
            return;
          }
          final pickItemReceiveProvider =
              Provider.of<PickItemReceiveRtvProvider>(context, listen: false);
          pickItemReceiveProvider.inputQtyNonBatch(
            item,
            double.parse(_quantity.text),
          );
          Navigator.of(context)
              .pushNamed(PickListBinRtvScreen.routeName, arguments: item);
          //  Navigator.of(context).pop();
        },
      ),
    );
  }
}
