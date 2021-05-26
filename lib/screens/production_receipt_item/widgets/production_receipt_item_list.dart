import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_item_batch_model.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_receipt_item/widgets/production_receipt_item_batch_list_box.dart';
import 'package:msi_app/screens/production_receipt_item/widgets/production_receipt_item_qty_dialog.dart';
import 'package:msi_app/screens/production_receipt_item/widgets/production_receipt_item_qty_non_batch_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionReceiptItemList extends StatelessWidget {
  final ProductionReceiptItemModel item;

  const ProductionReceiptItemList(this.item);

  @override
  Widget build(BuildContext context) {
final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? ProductionReceiptItemQtyDialog(item)
              : ProductionReceiptItemQtyNonBatchDialog(item),
        );
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
                'Production Quantity',
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
            BaseTextLine('UoM', item.uom),
            BaseTextLine('Item Batch', item.fgBatch),
            Divider(),
            if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionReceiptItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionReceiptItemBatchListBox(item, list[index]);
      },
    );
  }
}
