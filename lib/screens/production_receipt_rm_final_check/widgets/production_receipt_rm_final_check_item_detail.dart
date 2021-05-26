import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_final_check/widgets/production_receipt_rm_final_check_item_batch_detail.dart';
import 'package:msi_app/screens/production_receipt_rm_final_check/widgets/production_receipt_rm_final_check_item_bin_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMFinalCheckItemDetail extends StatelessWidget {
  final ProductionReceiptRMItemListModel item;

  const ProductionReceiptRMFinalCheckItemDetail(this.item);

  @override
  Widget build(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.itemCode),
          BaseTitle(item.description),
          Divider(),
          BaseTextLine(
              'Receive Quantity',
              item.openQty == 0.0
                  ? item.openQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.openQty)),
          BaseTextLine(
              'Pick Quantity',
              item.pickedQty == 0.0
                  ? item.pickedQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.pickedQty)),
          BaseTextLine(
              'Remaining Quantity',
              item.quantity == 0.0
                  ? item.quantity.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.quantity)),
          BaseTextLine('Item Batch', item.fgBatch),
          BaseTextLine('UOM', item.unitMsr),
          // BaseTextLine('Bin Location', item.itemStorageLocation),
          Divider(),
          if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
          if (item.fgBatch == 'N') buildItemBin(item.batchList),
        ],
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
        return ProductionReceiptRMFinalCheckItemBatchDetail(list[index]);
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
        return ProductionReceiptRMFinalCheckItemBinDetail(list[index]);
      },
    );
  }
}
