import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemBatchBox extends StatelessWidget {
  final ProductionIssueItemModel item;
  final ProductionIssueItemBatchModel batch;

  const ProductionIssueItemBatchBox(this.item, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductionIssueItemProvider>(context, listen: false);
 final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatchItem(item, batch);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', batch.batchNo),
                BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine('UOM', batch.uom),
                BaseTextLine('Quantity', batch.putQty == 0.0
                  ? batch.putQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(batch.putQty)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
