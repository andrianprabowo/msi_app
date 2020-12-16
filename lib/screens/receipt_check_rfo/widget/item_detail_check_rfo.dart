import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/screens/receipt_check_rfo/widget/item_batch_check_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemDetailCheckRfo extends StatelessWidget {
  final ItemPurchaseOrderRfo item;

  const ItemDetailCheckRfo(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.itemCode),
          BaseTitle(item.description),
          Divider(),
          BaseTextLine('PO Quantity', item.openQty.toStringAsFixed(4)),
          BaseTextLine('Receipt Quantity', item.quantity.toStringAsFixed(4)),
          BaseTextLine(
              'Remaining Quantity', item.remainingQty.toStringAsFixed(4)),
          BaseTextLine('UoM', item.uom),
          Divider(),
          if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          buildItemBatchList(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<ItemBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ItemBatchCheckRfo(list[index]);
      },
    );
  }
}
