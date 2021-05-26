import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_receipt_final_check/widgets/production_receipt_item_batch_list_final.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionReceiptItemListFinal extends StatelessWidget {
  final ProductionReceiptItemModel item;

  const ProductionReceiptItemListFinal(this.item);

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
              'PO Quantity',
              item.openQty == 0.0
                  ? item.openQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.openQty)),
          BaseTextLine(
              'Complete Quantity',
              item.quantity == 0.0
                  ? item.quantity.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.quantity)),
          BaseTextLine(
              'Reject Quantity',
              item.quantityReject == 0.0
                  ? item.quantityReject.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.quantityReject)),
          BaseTextLine(
              'Remaining Quantity',
              item.remainingQty == 0.0
                  ? item.remainingQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.remainingQty)),
          BaseTextLine('UOM', item.uom),
          Divider(),
          if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          buildItemBatchList(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionReceiptItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionReceiptItemBatchListFinal(list[index]);
      },
    );
  }
}
