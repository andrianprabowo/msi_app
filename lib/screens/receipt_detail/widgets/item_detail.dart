import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_input_non_batch.dart';
import 'package:msi_app/screens/receipt_detail/widgets/item_batch_widget.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_input_qty.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatelessWidget {
  final ItemPurchaseOrder item;

  const ItemDetail(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
            final numUom = formatter.format(item.numInBuy)+" "+ item.unitMsr;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQty(item)
              : DialogInputQtyNonBatch(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            // BaseTitleColor(item.itemCode),
            BaseTitle(item.description),
            Divider(),
            BaseTextLine(
                'PO Quantity',
                item.openQty == 0.0
                    ? item.openQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.openQty)),
            BaseTextLine(
                'Receipt Quantity',
                item.quantity == 0.0
                    ? item.quantity.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.quantity)),
            BaseTextLine(
                // 'Remaining Quantity', item.remainingQty.toStringAsFixed(authProvider.decLen)),
                'Remaining Quantity',
                item.remainingQty == 0.0
                    ? item.remainingQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.remainingQty)),
            BaseTextLine('UoM', item.uom),
            BaseTextLine('Item Batch', item.fgBatch),
            BaseTextLine('Item per unit ', numUom),
            Divider(),
            if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<ItemBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ItemBatchWidget(item, list[index]);
      },
    );
  }
}
