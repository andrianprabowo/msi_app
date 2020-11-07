import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch.dart';
import 'package:msi_app/models/inventory_dispatch_item.dart';
import 'package:msi_app/screens/inventory_dispatch_bin/inventory_dispatch_bin_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item/widgets/dialog_inv_disp_nonbatch.dart';
import 'package:msi_app/screens/inventory_dispatch_item/widgets/inventory_dispatch_batch_widget.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemInventoryDispatchItem extends StatelessWidget {
  final InventoryDispatchItem item;

  const ItemInventoryDispatchItem(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.fgBatch == 'Y') {
          Navigator.of(context)
              .pushNamed(InventoryDispatchBinScreen.routeName, arguments: item);
        } else {
          item.itemStorageLocation = item.itemStorageLocation;
          showModalBottomSheet(
              context: context, builder: (_) => DialogInvDispNonbatch(item));
        }
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
            BaseTextLine('Total To Dispatch', item.openQty.toStringAsFixed(2)),
            BaseTextLine('Remaining Qty', item.quantity.toStringAsFixed(2)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('Bin Location', item.itemStorageLocation),
            // if (item.pickedQty != 0)
            BaseTextLine('Picked Qty', item.pickedQty.toStringAsFixed(2)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<InventoryDispatchBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return InventoryDispatchBatchWidget(item, list[index]);
      },
    );
  }
}
