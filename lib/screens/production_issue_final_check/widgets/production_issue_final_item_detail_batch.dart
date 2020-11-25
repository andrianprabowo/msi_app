import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ProductionIssueFinalItemDetailBatch extends StatelessWidget {
  final ProductionIssueItemBatchModel item;

  const ProductionIssueFinalItemDetailBatch(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine('UOM', item.uom),
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
