import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/screens/pick_item_batch/widget/dialog_expired.dart';
import 'package:msi_app/screens/pick_item_batch/widget/dialog_pick_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ItemPickBatch extends StatelessWidget {
  final PickBatch item;
  final PickItemReceive itemRec;

  const ItemPickBatch(this.item, this.itemRec);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        // final date = '2021-02-24';
        final date = new DateTime.now();

        if (item.expiredDate.isAfter(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogPickBatch(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogExpired(item),
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
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(4)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine(
                'Remaining Qty',
                item.remainQty == 0.0
                    ? item.remainQty.toStringAsFixed(4)
                    : formatter.format(item.remainQty)),
            BaseTextLine(
                'Picked Qty',
                item.pickQty == 0.0
                    ? item.pickQty.toStringAsFixed(4)
                    : formatter.format(item.pickQty)),
          ],
        ),
      ),
    );
  }
}
