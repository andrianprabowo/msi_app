import 'package:flutter/material.dart';
import 'package:msi_app/models/item_po_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

import 'dialog_input_qty.dart';

class ItemBatch extends StatelessWidget {
  final ItemPoBatch item;

  const ItemBatch(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context, builder: (_) => DialogInputQty(item));
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
