import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionReceiptItemBatchListFinal extends StatelessWidget {
  final ProductionReceiptItemBatchModel item;

  const ProductionReceiptItemBatchListFinal(this.item);

  @override
  Widget build(BuildContext context) {
final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine(
              'Complete Quantity',
              item.availableQty == 0.0
                  ? item.availableQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.availableQty)),
          BaseTextLine(
              'Reject Quantity',
              item.rejectQty == 0.0
                  ? item.rejectQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.rejectQty)),
        ],
      ),
    );
  }
}
