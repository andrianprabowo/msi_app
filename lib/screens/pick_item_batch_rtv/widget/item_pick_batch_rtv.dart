import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/widget/dialog_pick_batch_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemPickBatchRtv extends StatelessWidget {
  final PickBatchRtv item;

  const ItemPickBatchRtv(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPickBatchRtv(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch No', item.batchNo),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('Uom', item.uom),
            BaseTextLine('Remaining Qty', item.remainQty.toStringAsFixed(2)),
            BaseTextLine('Picked Qty', item.pickQty.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
