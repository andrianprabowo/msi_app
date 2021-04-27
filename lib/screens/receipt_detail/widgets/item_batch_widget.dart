import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/providers/item_po_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemBatchWidget extends StatelessWidget {
  final ItemPurchaseOrder itemPo;
  final ItemBatch item;

  const ItemBatchWidget(this.itemPo, this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    final itemPoProvider = Provider.of<ItemPoProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              itemPoProvider.removeBatch(itemPo, item);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', item.batchNo),
                BaseTextLine('Expired Date', convertDate(item.expiredDate)),
                BaseTextLine('Quantity', 
              item.availableQty == 0.0
                  ? item.availableQty.toStringAsFixed(4)
                  : formatter.format(item.availableQty)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
