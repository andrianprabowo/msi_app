import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/screens/staging_check/widgets/staging_batch_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class StagingDetailCheck extends StatelessWidget {
  final ItemBin item;

  const StagingDetailCheck(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.itemCode),
          BaseTitle(item.itemName),
          Divider(),
          BaseTextLine(
              'Available Quantity', item.availableQty.toStringAsFixed(4)),
          BaseTextLine('Put Quantity', item.putQty.toStringAsFixed(4)),
          BaseTextLine('Bin Location', item.binCodeDestination),
          Divider(),
          if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          buildItemBatchList(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<PutBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return StagingBatchCheck(list[index]);
      },
    );
  }
}
