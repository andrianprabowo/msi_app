import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/put_batch_si.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemBatchStagingSi extends StatelessWidget {
  final PutBatchSi item;

  const ItemBatchStagingSi(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      // onTap: () {
      //   showModalBottomSheet(
      //     context: context,
      //     builder: (_) => DialogPutAwayRfo(item),
      //   );
      // },
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
            // BaseTextLine('Put Qty', item.putQty.toStringAsFixed(4)),
          ],
        ),
      ),
    );
  }
}
