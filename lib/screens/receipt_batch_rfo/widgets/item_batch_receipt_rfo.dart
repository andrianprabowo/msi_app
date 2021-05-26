import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_batch_rfo.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/receipt_batch_rfo/widgets/dialog_receipt_batch_rfo.dart';
import 'package:msi_app/screens/receipt_batch_rfo/widgets/expired_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemBatchReceiptBatchRfo extends StatelessWidget {
  final ItemBatchRfo item;

  const ItemBatchReceiptBatchRfo(this.item);

  @override
  Widget build(BuildContext context) {
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        final date = new DateTime.now();

        if (item.expiredDate.isAfter(date)) {
          print("sssss${item.expiredDate}.");
          print("zzz$date.");

          showModalBottomSheet(
            context: context,
            builder: (_) => DialogReceiptBatchRfo(item),
          );
        } else {
          print("object${item.expiredDate}.");
          showModalBottomSheet(
            context: context,
            builder: (_) => ExpiredDialogReceipt(item),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch Number', item.batchNo),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine(
                'Put Qty',
                item.putQty == 0.0
                    ? item.putQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.putQty)),
          ],
        ),
      ),
    );
  }
}
