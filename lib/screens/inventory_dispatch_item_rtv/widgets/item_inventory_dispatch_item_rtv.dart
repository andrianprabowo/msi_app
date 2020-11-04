import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch_rtv.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';
import 'package:msi_app/screens/inventory_dispatch_bin_rtv/inventory_dispatch_bin_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item_rtv/widgets/dialog_inv_disp_nonbatch_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

import 'inventory_dispatch_batch_widget_rtv.dart';

class ItemInventoryDispatchItemRtv extends StatelessWidget {
  final InventoryDispatchItemRtv item;

  const ItemInventoryDispatchItemRtv(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(InventoryDispatchBinRtvScreen.routeName, arguments: item)
            : showModalBottomSheet(
                context: context, builder: (_) => DialogInvDispNonbatchRtv(item));
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

  Widget buildItemBatchList(List<InventoryDispatchBatchRtv> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return InventoryDispatchBatchWidgetRtv(item, list[index]);
      },
    );
  }
}
