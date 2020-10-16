import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/screens/staging_batch/staging_batch_screen.dart';
import 'package:msi_app/screens/staging_item/widgets/put_batch_widget.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStagingBin extends StatelessWidget {
  final ItemBin item;

  const ItemStagingBin(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StagingBatchScreen.routeName,
          arguments: item,
        );
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
            if (item.binCodeDestination.isNotEmpty)
              BaseTextLine('Bin Code', item.binCodeDestination),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
            if (item.putQty != 0)
              BaseTextLine('Picked Qty', item.putQty.toStringAsFixed(2)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PutBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PutBatchWidget(item, list[index]);
      },
    );
  }
}
