import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/providers/production_issue_item_batch_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemBatchListDialog extends StatefulWidget {
  final ProductionIssueItemBatchModel item;

  const ProductionIssueItemBatchListDialog(this.item);

  @override
  _ProductionIssueItemBatchListDialogState createState() =>
      _ProductionIssueItemBatchListDialogState();
}

class _ProductionIssueItemBatchListDialogState
    extends State<ProductionIssueItemBatchListDialog> {
  final _quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    var avlQty = widget.item.availableQty == 0.0
        ? widget.item.availableQty.toStringAsFixed(4)
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
          if (_quantity.text != '' &&
                  (double.tryParse(_quantity.text) >
                      double.tryParse(
                          widget.item.availableQty.toStringAsFixed(4))) ||
              _quantity.text == '0')
            buildButtonNotif(context, avlQty)
          else
            buildButtonSubmit(context)
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

  Widget buildButtonSubmit(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Submit'),
        onPressed: () {
          // handle if input not double to return nothing
          double qty;
          try {
            qty = double.parse(_quantity.text);
          } on FormatException {
            return;
          }

          Provider.of<ProductionIssueItemBatchProvider>(context, listen: false)
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
