import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/screens/staging_check_rfo/widgets/staging_batch_check_rfo.dart';
import 'package:msi_app/screens/staging_check_rfo/widgets/staging_bin_check_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class StagingDetailCheckRfo extends StatelessWidget {
  final ItemBinRfo item;

  const StagingDetailCheckRfo(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
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
              'Available Quantity',
              item.availableQty == 0.0
                  ? item.availableQty.toStringAsFixed(4)
                  : formatter.format(item.availableQty)),
          BaseTextLine(
              'Put Quantity',
              item.putQty == 0.0
                  ? item.putQty.toStringAsFixed(4)
                  : formatter.format(item.putQty)),
          // BaseTextLine('Bin Location', item.binCodeDestination),
          Divider(),
          // if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          // buildItemBatchList(item.batchList),
          if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
          if (item.fgBatch == 'N') buildItemBin(item.batchList),
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

  Widget buildItemBin(List<PutBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return StagingBinCheckRfo(list[index]);
      },
    );
  }
}
