import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/screens/staging_batch_rfo/staging_batch_rfo_screen.dart';
import 'package:msi_app/screens/staging_item_rfo/widgets/dialog_put_away_nonbatch_rfo.dart';
import 'package:msi_app/screens/staging_item_rfo/widgets/put_batch_widget_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStagingBinRfo extends StatelessWidget {
  final ItemBinRfo item;

  const ItemStagingBinRfo(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(StagingBatchRfoScreen.routeName, arguments: item)
            : showModalBottomSheet(
                context: context, builder: (_) => DialogPutAwayNonbatchRfo(item));
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Item Code', item.itemCode),
            BaseTextLine('Item Name', item.itemName),
            BaseTextLine('Item Batch', item.fgBatch),
            BaseTextLine('Put Qty', item.putQty.toStringAsFixed(4)),
            if (item.binCodeDestination.isNotEmpty)
              BaseTextLine('Bin Code', item.binCodeDestination),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(4)),
            BaseTextLine('Uom', item.uom),
            if (item.putQty != 0)
              BaseTextLine('Picked Qty', item.putQty.toStringAsFixed(4)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PutBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PutBatchWidgetRfo(item, list[index]);
      },
    );
  }
}
