import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_change_model.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_change_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/screens/production_issue_item/production_issue_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

import '../production_issue_item_change_screen.dart';

class ProductionIssueItemChangeDialog extends StatefulWidget {
  final ProductionIssueItemChangeModel item;

  const ProductionIssueItemChangeDialog(this.item);

  @override
  _ProductionIssueItemChangeDialogState createState() =>
      _ProductionIssueItemChangeDialogState();
}

class _ProductionIssueItemChangeDialogState
    extends State<ProductionIssueItemChangeDialog> {
  final _quantity = TextEditingController();

  ProductionIssueItemChangeModel get item {
    return widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final itemChange =
        Provider.of<ProductionIssueItemProvider>(context, listen: false)
            .selected;
    // var avlQty = widget.item.availableQty == 0.0
    //     ? widget.item.availableQty.toStringAsFixed(authProvider.decLen)
    //     : formatter.format(widget.item.availableQty);
    return Container(
      padding: const EdgeInsets.all(kLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTitleColor(itemChange.itemCode),
          BaseTitleColor(itemChange.itemName),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitleColor('Will Be Change With'),
          SizedBox(height: getProportionateScreenHeight(kLarge)),
          BaseTitle(item.itemCode),
          BaseTitle(item.itemName),
          // SizedBox(height: getProportionateScreenHeight(kLarge)),
          // BaseTextLine('Planned Quantity', avlQty),
          // SizedBox(height: getProportionateScreenHeight(kLarge)),
          // buildQtyFormField(),
          // SizedBox(height: getProportionateScreenHeight(kLarge)),
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
    final itemChange =
        Provider.of<ProductionIssueItemProvider>(context, listen: false)
            .selected;
    final newItem =
        Provider.of<ProductionIssueItemChangeProvider>(context, listen: false)
            .selected;
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text('OK'),
        onPressed: () {
          itemChange.oldItemCode = itemChange.itemCode;
          itemChange.oldItemName = itemChange.itemName;
          itemChange.itemCode = newItem.itemCode;
          itemChange.itemName = newItem.itemName;
          // itemChange.putQty = newItem.putQty;
          // itemChange.availableQty = newItem.availableQty;
          // itemChange.totQty = newItem.totQty;
          // itemChange.unitMsr = newItem.unitMsr;
          // itemChange.binCode = newItem.binCode;
          // itemChange.binCodeDestination = newItem.binCodeDestination;
          Navigator.of(context).pop();
          Navigator.of(context)
                  .popUntil(ModalRoute.withName(ProductionIssueItem.routeName));
        //  Navigator.of(context)
        //       .pushNamed(ProductionIssueItemChange.routeName, arguments: item);
        // Navigator.of(context)
        //           .popUntil(ModalRoute.withName(ProductionIssueItem.routeName));
         
        
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
