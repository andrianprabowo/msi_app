import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/screens/receipt_item/receipt_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemDetail extends StatelessWidget {
  final ItemPurchaseOrder item;

  const ItemDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ReceiptItemScreen.routeName,
          arguments: item,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.description),
            Divider(),
            BaseTextLine('Open Qty', item.openQty.toStringAsFixed(2)),
            BaseTextLine('Qty', item.quantity.toStringAsFixed(2)),
            BaseTextLine('UoM', item.uom)
          ],
        ),
      ),
    );
  }
}
