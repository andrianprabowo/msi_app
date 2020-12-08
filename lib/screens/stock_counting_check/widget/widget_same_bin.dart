import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_check/stock_counting_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class WidgetSameBin extends StatefulWidget {
  final StockCountingItem item;

  const WidgetSameBin(this.item);

  @override
  _WidgetSameBinState createState() =>
      _WidgetSameBinState();
}

class _WidgetSameBinState extends State<WidgetSameBin> {
  final _quantity = TextEditingController();

  StockCountingItem get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTextLine('Item Code', item.itemCode),
          SizedBox(height: getProportionateScreenHeight(kMedium)),
          BaseTextLine('Item Name', item.description),
          SizedBox(height: getProportionateScreenHeight(kMedium)),
          BaseTextLine('Item Batch', item.fgBatch),
          SizedBox(height: getProportionateScreenHeight(kMedium)),
          BaseTitle('Input Quantity'),
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
          final pickItemReceiveProvider =
              Provider.of<StockCountingItemProvider>(context, listen: false);
          pickItemReceiveProvider.inputQty(
            item,
            double.parse(_quantity.text),
          );

          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamed(StockCountingCheckScreen.routeName, arguments: item);
          // Navigator.of(context).popUntil(
          //         ModalRoute.withName(StockCountingBinScreen.routeName));
        },
      ),
    );
  }
}
