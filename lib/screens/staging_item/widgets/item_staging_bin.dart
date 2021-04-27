import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/screens/staging_batch/staging_batch_screen.dart';
import 'package:msi_app/screens/staging_item/widgets/put_batch_widget.dart';
import 'package:msi_app/screens/staging_item/widgets/put_bin_widget.dart';
import 'package:msi_app/screens/storage_bin_item/storage_bin_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStagingBin extends StatelessWidget {
  final ItemBin item;

  const ItemStagingBin(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    final numUom = formatter.format(item.numInBuy) + " " + item.unitMsr;
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(StagingBatchScreen.routeName, arguments: item)
            : Navigator.of(context)
                .pushNamed(StorageBinItemScreen.routeName, arguments: item);
        // showModalBottomSheet(
        //     context: context, builder: (_) => DialogPutAwayNonbatch(item));
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
            BaseTextLine(
                'Picked Qty',
                item.putQty == 0.0
                    ? item.putQty.toStringAsFixed(4)
                    : formatter.format(item.putQty)),
            // if (item.binCodeDestination.isNotEmpty)
            //   BaseTextLine('Bin Code', item.binCodeDestination),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(4)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Uom', item.uom),
            // if (item.putQty != 0)
            BaseTextLine(
                'Remaining Qty',
                item.remainingQty == 0.0
                    ? item.remainingQty.toStringAsFixed(4)
                    : formatter.format(item.remainingQty)),
            BaseTextLine(
                'Item per unit',numUom),
            if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
            if (item.fgBatch == 'N') buildItemBin(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PutBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PutBatchWidget(item, list[index]);
      },
    );
  }

  Widget buildItemBin(List<PutBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PutBinWidget(item, list[index]);
      },
    );
  }
}
