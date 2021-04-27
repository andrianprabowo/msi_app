import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/storage_bin_item.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/item_batch_provider.dart';
import 'package:msi_app/providers/item_bin_provider.dart';
import 'package:msi_app/screens/staging_item/staging_item_screen.dart';
import 'package:msi_app/screens/staging_item/widgets/dialog_put_away_nonbatch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStorageBinItem extends StatelessWidget {
  final ItemBin itemBin;
  final StorageBinItem storageBinItem;

  const ItemStorageBinItem(this.itemBin, this.storageBinItem);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        final itemBinProvider =
            Provider.of<ItemBinProvider>(context, listen: false);
        final itemBatchProvider =
            Provider.of<ItemBatchProvider>(context, listen: false);
        // update bin location
        itemBin.binCodeDestination = storageBinItem.binCode;
        // add batch list
        if (itemBin.fgBatch == "Y") {
          final batchList = itemBatchProvider.pickedItems;
          batchList.forEach((detail) {
            // calculate bin
            detail.bin = storageBinItem.binCode;
          });
          itemBinProvider.addBatchList(itemBin, batchList);
          Navigator.of(context)
              .popUntil(ModalRoute.withName(StagingItemScreen.routeName));
        } else {
          // final select = itemBatchProvider.pickedItems;

          // final batchListq = itemBatchProvider.pickedItems;
          // itemBinProvider.inputQtyNonBatch(itemBin, itemBin.putQty);
          // final batchList =
          //     PutBatch(putQty: itemBin.putQty, bin: itemBin.binCodeDestination);
          // itemBinProvider.addBin(itemBin, batchList);

          showModalBottomSheet(
              context: context, builder: (_) => DialogPutAwayNonbatch(itemBin));
          // print("inininin ${itemBin.putQty}");
          // print("inininin2222rrr ${batchListq.first.putQty}");
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location', storageBinItem.binCode),
            BaseTextLine('Warehouse', authProvider.warehouseName),
          ],
        ),
      ),
    );
  }
}
