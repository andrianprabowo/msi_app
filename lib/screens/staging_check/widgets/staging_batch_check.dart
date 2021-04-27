import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class StagingBatchCheck extends StatelessWidget {
  final PutBatch item;

  const StagingBatchCheck(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.bin),
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine(
              'Put Qty',
              item.putQty == 0.0
                  ? item.putQty.toStringAsFixed(4)
                  : formatter.format(item.putQty)),
        ],
      ),
    );
  }
}
