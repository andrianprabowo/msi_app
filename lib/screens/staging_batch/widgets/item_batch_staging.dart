import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/screens/staging_batch/widgets/dialog_put_away.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemBatchStaging extends StatelessWidget {
  final PutBatch item;

  const ItemBatchStaging(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPutAway(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch Number', item.batchNo),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(4)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('uom', item.uom),
            BaseTextLine('Picked Qty', item.putQty.toStringAsFixed(4)),
          ],
        ),
      ),
    );
  }
}
