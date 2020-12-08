import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemBatchWidgetSc extends StatelessWidget {
 final StockCountingItem pickItem;
  final StockCountingBatch batch;

  const ItemBatchWidgetSc(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatch(pickItem, batch);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', batch.batchNo),
                BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
