import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_batch_provider.dart';
import 'package:msi_app/screens/stock_counting_batch/widget/dialog_pick_batch_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStockCountingBatch extends StatelessWidget {
  final StockCountingBatch item;

  const ItemStockCountingBatch(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final provider =
        Provider.of<StockCountingBatchProvider>(context, listen: false);

    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    print(' item flag ${item.flagSo}');

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
        child: Row(
          children: [
            if (item.flagSo == 0)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  provider.removeBatch(item);
                },
              ),
            Expanded(
              child: Column(
                children: [
                  BaseTextLine('Batch Number', item.batchNo),
                  BaseTextLine('Expired Date', convertDate(item.expiredDate)),
                  BaseTextLine('Count Qty', 
                    item.pickQty == 0.0
                        ? item.pickQty.toStringAsFixed(authProvider.decLen)
                        : formatter.format(item.pickQty)),
                  BaseTextLine('Uom', item.uom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
