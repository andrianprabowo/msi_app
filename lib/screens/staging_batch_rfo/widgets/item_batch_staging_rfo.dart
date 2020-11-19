import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/screens/staging_batch_rfo/widgets/dialog_put_away_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemBatchStagingRfo extends StatelessWidget {
  final PutBatchRfo item;

  const ItemBatchStagingRfo(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPutAwayRfo(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch Number', item.batchNo),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine('Put Qty', item.putQty.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
