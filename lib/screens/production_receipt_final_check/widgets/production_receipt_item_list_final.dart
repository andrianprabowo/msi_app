import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/screens/production_receipt_final_check/widgets/production_receipt_item_batch_list_final.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionReceiptItemListFinal extends StatelessWidget {
  final ProductionReceiptItemModel item;

  const ProductionReceiptItemListFinal(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
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
                  ? item.openQty.toStringAsFixed(4)
                  : formatter.format(item.openQty)),
          BaseTextLine(
              'Complete Quantity',
              item.quantity == 0.0
                  ? item.quantity.toStringAsFixed(4)
                  : formatter.format(item.quantity)),
          BaseTextLine(
              'Reject Quantity',
              item.quantityReject == 0.0
                  ? item.quantityReject.toStringAsFixed(4)
                  : formatter.format(item.quantityReject)),
          BaseTextLine(
              'Remaining Quantity',
              item.remainingQty == 0.0
                  ? item.remainingQty.toStringAsFixed(4)
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
