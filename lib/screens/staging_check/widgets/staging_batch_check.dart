import 'package:flutter/material.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class StagingBatchCheck extends StatelessWidget {
  final PutBatch item;

  const StagingBatchCheck(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine('Put Qty', item.putQty.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
