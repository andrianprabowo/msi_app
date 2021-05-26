import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/models/put_batch_rfo.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/staging_batch_rfo/staging_batch_rfo_screen.dart';
import 'package:msi_app/screens/staging_item_rfo/widgets/put_batch_widget_rfo.dart';
import 'package:msi_app/screens/staging_item_rfo/widgets/put_bin_widget_rfo.dart';
import 'package:msi_app/screens/storage_bin_item_rfo/storage_bin_item_rfo_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStagingBinRfo extends StatelessWidget {
  final ItemBinRfo item;

  const ItemStagingBinRfo(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(StagingBatchRfoScreen.routeName, arguments: item)
            : Navigator.of(context)
                .pushNamed(StorageBinItemRfoScreen.routeName, arguments: item);

        // showModalBottomSheet(
        //     context: context, builder: (_) => DialogPutAwayNonbatchRfo(item));
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
                'Put Qty',
                item.putQty == 0.0
                    ? item.putQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.putQty)),
            // if (item.binCodeDestination.isNotEmpty)
            //   BaseTextLine('Bin Code', item.binCodeDestination),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Uom', item.uom),
            // if (item.putQty != 0)
            BaseTextLine(
                'Remaining Qty',
                item.remainingQty == 0.0
                    ? item.remainingQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.remainingQty)),
            // buildItemBatchList(item.batchList),
            if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
            if (item.fgBatch == 'N') buildItemBin(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PutBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PutBatchWidgetRfo(item, list[index]);
      },
    );
  }

  Widget buildItemBin(List<PutBatchRfo> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PutBinWidgetRfo(item, list[index]);
      },
    );
  }
}
