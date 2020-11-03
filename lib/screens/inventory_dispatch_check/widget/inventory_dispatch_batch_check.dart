import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class InventoryDispatchBatchCheck extends StatelessWidget {
  final InventoryDispatchBatch item;

  const InventoryDispatchBatchCheck(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine('Picked Qty', item.pickQty.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
