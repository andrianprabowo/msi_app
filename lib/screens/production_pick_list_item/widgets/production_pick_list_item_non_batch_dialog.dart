import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/screens/production_pick_list_bin/production_pick_list_bin_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
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
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    var openQty = widget.item.openQty == 0.0
        ? widget.item.openQty.toStringAsFixed(4)
        : formatter.format(widget.item.openQty);
    return Container(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitle('Input Quantity'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine('Available Quantity', openQty),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          if (_quantity.text != '' &&
                  (double.parse(_quantity.text) >
                      double.tryParse(
                          widget.item.openQty.toStringAsFixed(4))) ||
              _quantity.text == '0')
            buildButtonNotif(context, openQty)
          else
            buildButtonSubmit(context),
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

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          final pickItemReceiveProvider =
              Provider.of<ProductionPickListItemProvider>(context,
                  listen: false);
          pickItemReceiveProvider.updateQtyNBinNonBatch(
              item, double.parse(_quantity.text), '');
          Navigator.of(context)
              .pushNamed(ProductionPickListBin.routeName, arguments: item);
          //  Navigator.of(context).pop();
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
