import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionPickListFinalDetailBatch extends StatelessWidget {
  final ProductionPickListItemBatchModel item;

  const ProductionPickListFinalDetailBatch(this.item);

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
          BaseTitle(item.bin),
          BaseTextLine('Batch Number', item.batchNo),
          BaseTextLine('Expired Date', convertDate(item.expiredDate)),
          BaseTextLine('UOM', item.uom),
          BaseTextLine(
              'Picked Qty',
              item.pickQty == 0.0
                  ? item.pickQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.pickQty)),
        ],
      ),
    );
  }
}
