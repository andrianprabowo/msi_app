import 'package:flutter/material.dart';
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
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.itemCode),
          BaseTitle(item.description),
          Divider(),
          BaseTextLine('Open Quantity', item.openQty.toStringAsFixed(4)),
          BaseTextLine('Pick Quantity', item.pickedQty.toStringAsFixed(4)),
          BaseTextLine('UoM', item.unitMsr),
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
