import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/screens/receipt_detail_rfo/widgets/dialog_input_non_batch_rfo.dart';
import 'package:msi_app/screens/receipt_detail_rfo/widgets/dialog_input_qty_rfo.dart';
import 'package:msi_app/screens/receipt_detail_rfo/widgets/item_batch_widget_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemDetailRfo extends StatelessWidget {
  final ItemPurchaseOrderRfo item;

  const ItemDetailRfo(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQtyRfo(item)
              : DialogInputQtyNonBatchRfo(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.description),
            Divider(),
            BaseTextLine('PO Quantity', item.openQty.toStringAsFixed(2)),
            BaseTextLine('Receipt Quantity', item.quantity.toStringAsFixed(2)),
            BaseTextLine(
                'Remaining Quantity', item.remainingQty.toStringAsFixed(2)),
            BaseTextLine('UoM', item.uom),
            BaseTextLine('Item Batch', item.fgBatch),
            Divider(),
            if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<ItemBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ItemBatchWidgetRfo(item, list[index]);
      },
    );
  }
}