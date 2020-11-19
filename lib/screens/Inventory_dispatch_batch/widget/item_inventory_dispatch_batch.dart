import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch/widget/dialog_inventory_dispatch_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemInventoryDispatchBatch extends StatelessWidget {
  final InventoryDispatchBatch item;

  const ItemInventoryDispatchBatch(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInventoryDispatchBatch(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch No', item.batchNo),
            BaseTextLine('Uom', item.uom),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
            BaseTextLine('Remaining Qty', item.remainQty.toStringAsFixed(2)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Picked Qty', item.pickQty.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
