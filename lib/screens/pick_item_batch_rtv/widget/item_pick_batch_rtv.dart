import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/widget/dialog_expired_rtv.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/widget/dialog_pick_batch_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ItemPickBatchRtv extends StatelessWidget {
  final PickBatchRtv item;
  final PickItemReceiveRtv itemRec;

  const ItemPickBatchRtv(this.item, this.itemRec);

  @override
  Widget build(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        final date = new DateTime.now();

        if (item.expiredDate.isAfter(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogPickBatchRtv(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogExpiredRtv(item),
          );
          print('expired ' + item.expiredDate.toString());
          print(date);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(itemRec.itemStorageLocation),
            BaseTextLine('Batch No', item.batchNo),
            BaseTextLine('Available Qty', 
                      item.availableQty == 0.0
                          ? item.availableQty.toStringAsFixed(authProvider.decLen)
                          : formatter.format(item.availableQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine('Remaining Qty', 
                      item.remainQty == 0.0
                          ? item.remainQty.toStringAsFixed(authProvider.decLen)
                          :  formatter.format(item.remainQty)),
            BaseTextLine('Picked Qty',  
                      item.pickQty == 0.0
                          ? item.pickQty.toStringAsFixed(authProvider.decLen)
                          : formatter.format(item.pickQty)),
          ],
        ),
      ),
    );
  }
}
