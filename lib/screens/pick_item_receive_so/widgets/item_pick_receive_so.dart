import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_so.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/screens/pick_item_bin_so/pick_list_bin_so_screen.dart';
import 'package:msi_app/screens/pick_item_receive_so/widgets/dialog_pick_list_nonbatch_so.dart';
import 'package:msi_app/screens/pick_item_receive_so/widgets/pick_batch_widget_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemPickReceiveSo extends StatelessWidget {
  final PickItemReceiveSo item;

  const ItemPickReceiveSo(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(PickListBinSoScreen.routeName, arguments: item)
            : showModalBottomSheet(
                context: context, builder: (_) => DialogPickListNonbatchSo(item));
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
            BaseTextLine('Remaining Qty', item.quantity.toStringAsFixed(4)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('Bin Location', item.itemStorageLocation),
            // if (item.pickedQty != 0)
            BaseTextLine('Picked Qty', item.pickedQty.toStringAsFixed(4)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PickBatchSo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBatchWidgetSo(item, list[index]);
      },
    );
  }
}
