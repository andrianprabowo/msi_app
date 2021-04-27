import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_dispatch_batch.dart';
import 'package:msi_app/models/inventory_dispatch_item.dart';
import 'package:msi_app/screens/inventory_dispatch_check/widget/inventory_dispatch_batch_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class InventoryDispatchDetailCheck extends StatelessWidget {
  final InventoryDispatchItem item;

  const InventoryDispatchDetailCheck(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');

    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.itemCode),
          BaseTitle(item.description),
          Divider(),
          BaseTextLine(
              'Total to Dispatch Quantity',
              item.openQty == 0.0
                  ? item.openQty.toStringAsFixed(4)
                  : formatter.format(item.openQty)),
          BaseTextLine(
              'Pick Quantity',
              item.pickedQty == 0.0
                  ? item.pickedQty.toStringAsFixed(4)
                  : formatter.format(item.pickedQty)),
          BaseTextLine(
              'Remaining Quantity ',
              item.quantity == 0.0
                  ? item.quantity.toStringAsFixed(4)
                  : formatter.format(item.quantity)),
          BaseTextLine('UoM', item.unitMsr),
          BaseTextLine('Bin location', item.itemStorageLocation),
          Divider(),
          if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          buildItemBatchList(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<InventoryDispatchBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return InventoryDispatchBatchCheck(list[index]);
      },
    );
  }
}
