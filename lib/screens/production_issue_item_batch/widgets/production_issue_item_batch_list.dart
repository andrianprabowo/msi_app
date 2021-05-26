import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_issue_item_batch/widgets/dialog_expired.dart';
import 'package:msi_app/screens/production_issue_item_batch/widgets/production_issue_item_batch_list_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemBatchList extends StatelessWidget {
  final ProductionIssueItemBatchModel item;

  const ProductionIssueItemBatchList(this.item);

  @override
  Widget build(BuildContext context) {
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        final date = new DateTime.now();

        if (item.expiredDate.isBefore(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogExpired(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => ProductionIssueItemBatchListDialog(item),
          );
          print('expired ' + item.expiredDate.toString());
          print(date);
        }
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
                    ? item.availableQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('UOM', item.uom),
            BaseTextLine(
                'Put Qty',
                item.putQty == 0.0
                    ? item.putQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.putQty)),
          ],
        ),
      ),
    );
  }
}
