import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_non_batch_sc.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_qty_batch.dart';
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
        item.fgBatch == 'Y'
            ? showModalBottomSheet(
                context: context, builder: (_) => DialogInputQtyBatch(item))
            // Navigator.of(context)
            //     .pushNamed(StockCountingBinScreen.routeName, arguments: item)
            : showModalBottomSheet(
                context: context, builder: (_) => DialogInputQtyNonBatchSc(item));
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
            BaseTextLine('Counted Qty', item.quantity.toStringAsFixed(2)),
            // BaseTextLine('Remaining Qty', item.quantity.toStringAsFixed(2)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('Bin Location', item.itemStorageLocation),
            // if (item.pickedQty != 0)
            // BaseTextLine('Picked Qty', item.pickedQty.toStringAsFixed(2)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<StockCountingBatch> list) {
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
