import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemBatchCheckRfo extends StatelessWidget {
  final ItemBatchRfo item;

  const ItemBatchCheckRfo(this.item);

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
          BaseTextLine('Quantity', formatter.format(item.putQty)),
          BaseTextLine('Uom', item.uom),
        ],
      ),
    );
  }
}
