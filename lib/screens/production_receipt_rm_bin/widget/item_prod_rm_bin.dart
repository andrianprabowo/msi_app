import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_bin.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_batch_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_item/production_receipt_rm_item_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_item/widgets/production_receipt_rm_item_non_batch_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemProdRmBin extends StatelessWidget {
  final ProductionReceiptRMItemListModel pickItemReceive;
  final ProductionReceiptRmBin item;

  const ItemProdRmBin(this.pickItemReceive, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        final itemBinProvider =
            Provider.of<ProductionReceiptRMItemListProvider>(context, listen: false);
        final itemBatchProvider =
            Provider.of<ProductionReceiptRMItemListBatchListProvider>(context,
                listen: false);
        // update bin location
        pickItemReceive.itemStorageLocation = item.binLocation;
        // add batch list
        if (pickItemReceive.fgBatch == 'Y') {
          final batchList = itemBatchProvider.items;
          batchList.forEach((detail) {
            // calculate bin
            detail.bin = item.binLocation;
          });
          itemBinProvider.addBatchList(pickItemReceive, batchList);

          Navigator.of(context)
              .popUntil(ModalRoute.withName(ProductionReceiptRMItem.routeName));
        } else {
          showModalBottomSheet(
              context: context, builder: (_) => ProductionReceiptRMItemNonBatchDialog(pickItemReceive));
         
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location', item.binLocation),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            // BaseTextLine('Qty','0.0000'),
          ],
        ),
      ),
    );
  }
}
