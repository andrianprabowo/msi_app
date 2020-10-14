import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/screens/pick_item_bin/pick_list_bin_screen.dart';
import 'package:msi_app/screens/pick_item_receive/widgets/pick_batch_widget.dart';
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
        Navigator.of(context)
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
            BaseTextLine('Total To Pick', item.openQty.toStringAsFixed(2)),
            BaseTextLine('Remaining Qty', item.quantity.toStringAsFixed(2)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('Bin Location', item.itemStorageLocation),
            if (item.pickedQty != 0)
              BaseTextLine('Picked Qty', item.pickedQty.toStringAsFixed(2)),
            buildItemBatchList(item.batchList),
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
}
