import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemInventoryDispatchDetail extends StatelessWidget {
  final InventoryDispatchDetail item;

  const ItemInventoryDispatchDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed(StagingItemScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.itemName),
            BaseTextLine('Total to Pick', item.totalToPick.toStringAsFixed(2)),
            BaseTextLine('Remaining Qty', item.remainingQty.toStringAsFixed(2)),
            BaseTextLine('Inventory UoM', item.inventoryUom),
            BaseTextLine('Batch Number', item.batchNumber.toString()),
          ],
        ),
      ),
    );
  }
}
