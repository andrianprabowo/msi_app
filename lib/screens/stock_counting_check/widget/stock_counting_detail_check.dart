import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/screens/stock_counting_check/widget/stock_counting_batch_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class StockCountingDetailCheck extends StatelessWidget {
  final StockCountingItem item;

  const StockCountingDetailCheck(this.item);

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
          BaseTitle(item.description),
          Divider(),
          BaseTextLine(
              'Count Quantity',
              item.quantity == 0.0
                  ? item.quantity.toStringAsFixed(4)
                  : formatter.format(item.quantity)),
          BaseTextLine('UoM', item.unitMsr),
          BaseTextLine('Item Batch', item.fgBatch),
          if (item.itemStorageLocation.isNotEmpty)
            BaseTextLine('Storage Bin', ''),
          if (item.itemStorageLocation.isNotEmpty)
            BaseTextLine('', item.itemStorageLocation),
          Divider(),
          if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          buildItemBatchList(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<StockCountingBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return StockCountingBatchCheck(list[index]);
      },
    );
  }
}
