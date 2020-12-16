import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/screens/staging_check_rfo/widgets/staging_batch_check_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class StagingDetailCheckRfo extends StatelessWidget {
  final ItemBinRfo item;

  const StagingDetailCheckRfo(this.item);

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

  Widget buildItemBatchList(List<PutBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return StagingBatchCheckRfo(list[index]);
      },
    );
  }
}
