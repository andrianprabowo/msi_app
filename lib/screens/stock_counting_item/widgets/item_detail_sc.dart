import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/screens/stock_counting_batch/stock_counting_batch_screen.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_non_batch_sc.dart';
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
        if (item.fgBatch == 'Y') {
          // print("BATCH");
          // Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamed(StockCountingBatchScreen.routeName, arguments: item);
        } else {
          // print("NON-BATCH");
          showModalBottomSheet(
              context: context, builder: (_) => DialogInputQtyNonBatchSc(item));
        }
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
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('Bin Location', ''),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('', item.itemStorageLocation),
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
