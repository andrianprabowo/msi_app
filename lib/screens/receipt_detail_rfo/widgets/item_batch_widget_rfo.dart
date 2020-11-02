import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/providers/item_po_provider_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemBatchWidgetRfo extends StatelessWidget {
  final ItemPurchaseOrderRfo itemPo;
  final ItemBatchRfo item;

  const ItemBatchWidgetRfo(this.itemPo, this.item);

  @override
  Widget build(BuildContext context) {
    final itemPoProvider = Provider.of<ItemPoRfoProvider>(context, listen: false);
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
                BaseTextLine('Quantity', item.availableQty.toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
