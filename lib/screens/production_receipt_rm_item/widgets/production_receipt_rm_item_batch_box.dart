import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMItemBatchBox extends StatelessWidget {
  final ProductionReceiptRMItemListModel pickItem;
  final ProductionReceiptRMItemListBatchListModel batch;

  const ProductionReceiptRMItemBatchBox(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductionReceiptRMItemListProvider>(context,
        listen: false);
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatchItem(pickItem, batch);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', batch.batchNo),
                BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine('UOM', batch.uom),
                BaseTextLine(
                    'Quantity',
                    batch.pickQty == 0.0
                        ? batch.pickQty.toStringAsFixed(4)
                        : formatter.format(batch.pickQty)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
