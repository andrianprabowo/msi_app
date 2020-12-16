import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_input_non_batch.dart';
import 'package:msi_app/screens/receipt_detail/widgets/item_batch_widget.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_input_qty.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemDetail extends StatelessWidget {
  final ItemPurchaseOrder item;

  const ItemDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQty(item)
              : DialogInputQtyNonBatch(item),
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
            BaseTextLine('PO Quantity', item.openQty.toStringAsFixed(4)),
            BaseTextLine('Receipt Quantity', item.quantity.toStringAsFixed(4)),
            BaseTextLine(
                'Remaining Quantity', item.remainingQty.toStringAsFixed(4)),
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

  Widget buildItemBatchList(List<ItemBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ItemBatchWidget(item, list[index]);
      },
    );
  }
}
