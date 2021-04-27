import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/screens/stock_counting_batch/widget/dialog_pick_batch_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStockCountingBatch extends StatelessWidget {
  final StockCountingBatch item;

  const ItemStockCountingBatch(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPickBatchSc(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch No', item.batchNo),
            // BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(4)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Count Qty', 
                    item.pickQty == 0.0
                        ? item.pickQty.toStringAsFixed(4)
                        : formatter.format(item.pickQty)),
          ],
        ),
      ),
    );
  }
}
