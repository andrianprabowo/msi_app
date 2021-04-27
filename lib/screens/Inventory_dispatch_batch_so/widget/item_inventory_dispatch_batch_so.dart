import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_dispatch_batch_so.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_so/widget/dialog_inventory_dispatch_batch_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemInventoryDispatchBatchSo extends StatelessWidget {
  final InventoryDispatchBatchSo item;

  const ItemInventoryDispatchBatchSo(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInventoryDispatchBatchSo(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch No', item.batchNo),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(4)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine(
                'Remaining Qty',
                item.remainQty == 0.0
                    ? item.remainQty.toStringAsFixed(4)
                    : formatter.format(item.remainQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine(
                'Picked Qty',
                item.pickQty == 0.0
                    ? item.pickQty.toStringAsFixed(4)
                    : formatter.format(item.pickQty)),
          ],
        ),
      ),
    );
  }
}
