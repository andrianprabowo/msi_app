import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_si.dart';
import 'package:msi_app/screens/stock_inquiry_batch/stock_inquiry_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStagingBinSi extends StatelessWidget {
  final ItemBinSi item;

  const ItemStagingBinSi(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.fgBatch == 'Y')
          Navigator.of(context)
              .pushNamed(StockInquiryBatchScreen.routeName, arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Item Code', item.itemCode),
            BaseTextLine('Item Name', item.itemName),
            BaseTextLine('Item Batch', item.fgBatch),
            // BaseTextLine('Put Qty', item.putQty.toStringAsFixed(4)),
            if (item.binCodeDestination.isNotEmpty)
              BaseTextLine('Bin Code', item.binCodeDestination),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(4)),
            if (item.putQty != 0)
              BaseTextLine('Picked Qty', item.putQty.toStringAsFixed(4)),
            // buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  // Widget buildItemBatchList(List<PutBatchSi> list) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: list.length,
  //     itemBuilder: (_, index) {
  //       return PutBatchWidget(item, list[index]);
  //     },
  //   );
  // }
}
