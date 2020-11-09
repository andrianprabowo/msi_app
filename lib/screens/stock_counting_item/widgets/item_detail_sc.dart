import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_non_batch_sc.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_qty_sc.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/item_batch_widget_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemDetailSc extends StatelessWidget {
  final StockCountingItem item;

  const ItemDetailSc(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQtySc(item)
              : DialogInputQtyNonBatchSc(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.itemDesc),
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

  Widget buildItemBatchList(List<ItemBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ItemBatchWidgetSc(item, list[index]);
      },
    );
  }
}
