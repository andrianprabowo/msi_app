import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_dispatch_batch_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class InventoryDispatchBatchCheckSo extends StatelessWidget {
  final InventoryDispatchBatchSo item;

  const InventoryDispatchBatchCheckSo(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine(
              'Picked Qty',
              item.pickQty == 0.0
                  ? item.pickQty.toStringAsFixed(4)
                  : formatter.format(item.pickQty)),
        ],
      ),
    );
  }
}
