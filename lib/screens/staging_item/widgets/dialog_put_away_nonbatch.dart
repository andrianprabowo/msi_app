import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/providers/item_bin_provider.dart';
import 'package:msi_app/screens/storage_bin_item/storage_bin_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class DialogPutAwayNonbatch extends StatefulWidget {
  final ItemBin item;

  const DialogPutAwayNonbatch(this.item);

  @override
  _DialogPutAwayNonbatchState createState() => _DialogPutAwayNonbatchState();
}

class _DialogPutAwayNonbatchState extends State<DialogPutAwayNonbatch> {
  final _quantity = TextEditingController();

  ItemBin get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Input Quantity'),
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
          if (double.parse(_quantity.text) > widget.item.availableQty) {
            print('Tidak boleh lebih besar dari Available Qty ');
            return;
          }
          final itemBinProvider =
              Provider.of<ItemBinProvider>(context, listen: false);
          itemBinProvider.inputQtyNonBatch(
            item,
            double.parse(_quantity.text),
          );
          Navigator.of(context).pushNamed(
            StorageBinItemScreen.routeName,
            arguments: item,
          );
        },
      ),
    );
  }
}
