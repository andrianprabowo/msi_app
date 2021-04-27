import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    final provider = Provider.of<ItemPoRfoProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatch(itemPo, item);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', item.batchNo),
                BaseTextLine('Expired Date', convertDate(item.expiredDate)),
                BaseTextLine(
                    'Quantity',
                    item.putQty == 0.0
                        ? item.putQty.toStringAsFixed(4)
                        : formatter.format(item.putQty)),
                BaseTextLine('Uom', item.uom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
