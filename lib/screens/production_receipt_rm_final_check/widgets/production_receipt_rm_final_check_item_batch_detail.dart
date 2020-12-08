import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ProductionReceiptRMFinalCheckItemBatchDetail extends StatelessWidget {
  final ProductionReceiptRMItemListBatchListModel item;

  const ProductionReceiptRMFinalCheckItemBatchDetail(this.item);

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
              'Picked Qty',
              item.pickQty == 0.0
                  ? item.pickQty.toStringAsFixed(4)
                  : formatter.format(item.pickQty)),
        ],
      ),
    );
  }
}