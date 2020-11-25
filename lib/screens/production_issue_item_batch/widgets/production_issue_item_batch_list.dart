import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/screens/production_issue_item_batch/widgets/production_issue_item_batch_list_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ProductionIssueItemBatchList extends StatelessWidget {
  final ProductionIssueItemBatchModel item;

  const ProductionIssueItemBatchList(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => ProductionIssueItemBatchListDialog(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch Number', item.batchNo),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(4)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('UOM', item.uom),
            BaseTextLine(
                'Put Qty',
                item.putQty == 0.0
                    ? item.putQty.toStringAsFixed(4)
                    : formatter.format(item.putQty)),
          ],
        ),
      ),
    );
  }
}
