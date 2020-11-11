import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class StockCountingBatchCheck extends StatelessWidget {
  final StockCountingBatch item;

  const StockCountingBatchCheck(this.item);

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
          BaseTextLine('Picked Qty', item.availableQty.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
