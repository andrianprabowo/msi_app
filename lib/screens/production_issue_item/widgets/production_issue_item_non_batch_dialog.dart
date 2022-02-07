import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemNonBatchDialog extends StatefulWidget {
  final ProductionIssueItemModel item;

  const ProductionIssueItemNonBatchDialog(this.item);

  @override
  _ProductionIssueItemNonBatchDialogState createState() =>
      _ProductionIssueItemNonBatchDialogState();
}

class _ProductionIssueItemNonBatchDialogState
    extends State<ProductionIssueItemNonBatchDialog> {
  final _quantity = TextEditingController();

  ProductionIssueItemModel get item {
    return widget.item;
  }

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
          BaseTitle('Input Quantity'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(item.itemCode),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(item.itemName),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTextLine('Planned Quantity', avlQty),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          buildQtyFormField(),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          // if (_quantity.text != '' &&
          //         (double.parse(_quantity.text) >
          //             double.tryParse(
          //                 widget.item.availableQty.toStringAsFixed(authProvider.decLen))) ||
          //     _quantity.text == '0')
          //   buildButtonNotif(context, avlQty)
          // else
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
          final itemNumberProvider =
                  Provider.of<ProductionIssueNumberProvider>(context,
                      listen: false);
           itemNumberProvider.selected.totalItem =
                    itemNumberProvider.selected.totalItem  -
                        1;
          final itemBinProvider =
              Provider.of<ProductionIssueItemProvider>(context, listen: false);
          itemBinProvider.inputQtyNonBatch(
            item,
            double.parse(_quantity.text),
          );
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
