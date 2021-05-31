import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/staging_batch/widgets/dialog_put_away.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemBatchStaging extends StatelessWidget {
  final PutBatch item;

  const ItemBatchStaging(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPutAway(item),
        );
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
            BaseTextLine('uom', item.uom),
            BaseTextLine(
                'Picked Qty',
                item.putQty == 0.0
                    ? item.putQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.putQty)),
                //      BaseTextLine(
                // 'temp Qty',
                // item.tempQty == 0.0
                //     ? item.tempQty.toStringAsFixed(authProvider.decLen)
                //     : formatter.format(item.tempQty)),
          ],
        ),
      ),
    );
  }
}
