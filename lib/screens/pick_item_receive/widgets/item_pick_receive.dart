import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/screens/pick_item_bin/pick_list_bin_screen.dart';
import 'package:msi_app/screens/pick_item_receive/widgets/pick_batch_widget.dart';
import 'package:msi_app/screens/pick_item_receive/widgets/pick_bin_widget.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemPickReceive extends StatelessWidget {
  final PickItemReceive item;

  const ItemPickReceive(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(PickListBinScreen.routeName, arguments: item)
            : Navigator.of(context)
                .pushNamed(PickListBinScreen.routeName, arguments: item);
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
            BaseTextLine('Total To Pick', item.openQty.toStringAsFixed(4)),
            BaseTextLine('Picked Qty', item.pickedQty.toStringAsFixed(4)),
            BaseTextLine('Remaining Qty', item.quantity.toStringAsFixed(4)),
            // BaseTextLine('Remaining Qty', item.quantity.toStringAsFixed(4)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            // if (item.itemStorageLocation.isNotEmpty)
            // BaseTextLine('Bin Location', item.itemStorageLocation),
            // if (item.pickedQty != 0)

            if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
            if (item.fgBatch == 'N') buildItemBin(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PickBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBatchWidget(item, list[index]);
      },
    );
  }

  Widget buildItemBin(List<PickBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBinWidget(item, list[index]);
      },
    );
  }
}
