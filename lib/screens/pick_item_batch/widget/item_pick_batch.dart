import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
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
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(4)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine('Remaining Qty', item.remainQty.toStringAsFixed(4)),
            BaseTextLine('Picked Qty', item.pickQty.toStringAsFixed(4)),
          ],
        ),
      ),
    );
  }
}
