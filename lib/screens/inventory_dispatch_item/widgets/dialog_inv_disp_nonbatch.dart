import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_item.dart';
import 'package:msi_app/providers/inventory_dispatch_item_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_bin/inventory_dispatch_bin_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class DialogInvDispNonbatch extends StatefulWidget {
  final InventoryDispatchItem item;

  const DialogInvDispNonbatch(this.item);

  @override
  _DialogInvDispNonbatchState createState() => _DialogInvDispNonbatchState();
}

class _DialogInvDispNonbatchState extends State<DialogInvDispNonbatch> {
  final _quantity = TextEditingController();

  InventoryDispatchItem get item {
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
              widget.item.openQty.toStringAsFixed(2)),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
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
          final inventoryDispatchItem =
              Provider.of<InventoryDispatchItemProvider>(context, listen: false);
          inventoryDispatchItem.inputQtyNonBatch(
            item,
            double.parse(_quantity.text),
            item.itemStorageLocation,
          );
           Navigator.of(context)
            .pushNamed(InventoryDispatchBinScreen.routeName, arguments: item);
            //  Navigator.of(context).pop();
        },
      ),
    );
  }
}
