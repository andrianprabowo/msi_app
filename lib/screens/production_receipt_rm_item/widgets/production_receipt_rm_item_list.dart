import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_bin/production_receipt_rm_bin_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_item/widgets/production_receipt_rm_item_batch_box.dart';
import 'package:msi_app/screens/production_receipt_rm_item/widgets/production_receipt_rm_item_bin_box.dart';
import 'package:msi_app/screens/production_receipt_rm_item_batch/production_receipt_rm_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMItemList extends StatelessWidget {
  final ProductionReceiptRMItemListModel item;

  const ProductionReceiptRMItemList(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');

    return InkWell(
      onTap: () {
        if (item.fgBatch == 'Y') {
          Navigator.of(context).pushNamed(
              ProductionReceiptRMItemBatch.routeName,
              arguments: item);
        } else {
          Navigator.of(context)
                .pushNamed(ProductionReceiptRmBinScreen.routeName, arguments: item);
          print('isi nya = $item');
          // showModalBottomSheet(
          //     context: context,
          //     builder: (_) => ProductionReceiptRMItemNonBatchDialog(item));
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
            BaseTextLine(
                'Total To Receipt',
                item.openQty == 0.0
                    ? item.openQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.openQty)),
            BaseTextLine(
                'Remaining Qty',
                item.quantity == 0.0
                    ? item.quantity.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.quantity)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            // if (item.itemStorageLocation.isNotEmpty)
            //   BaseTextLine('Bin Location', item.itemStorageLocation), 
            // if (item.pickedQty != 0)
            BaseTextLine(
                'Picked Qty',
                item.pickedQty == 0.0
                    ? item.pickedQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.pickedQty)),
                    if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
            if (item.fgBatch == 'N') buildItemBin(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(
      List<ProductionReceiptRMItemListBatchListModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionReceiptRMItemBatchBox(item, list[index]);
      },
    );
  }

   Widget buildItemBin(
      List<ProductionReceiptRMItemListBatchListModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionReceiptRMItemBinBox(item, list[index]);
      },
    );
  }
}
