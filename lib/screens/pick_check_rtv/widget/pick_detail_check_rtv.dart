import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/screens/pick_check_rtv/widget/pick_batch_check_rtv.dart';
import 'package:msi_app/screens/pick_check_rtv/widget/pick_bin_check_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class PickDetailCheckRtv extends StatelessWidget {
  final PickItemReceiveRtv item;

  const PickDetailCheckRtv(this.item);

  @override
  Widget build(BuildContext context) {
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
              'Total To Pick Quantity', item.openQty.toStringAsFixed(4)),
          // BaseTextLine('Pick Quantity', item.pickedQty.toStringAsFixed(4)),
          BaseTextLine('UoM', item.unitMsr),
          Divider(),
          // if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          // buildItemBatchList(item.batchList),
          if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
          if (item.fgBatch == 'N') buildItemBin(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<PickBatchRtv> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBatchCheckRtv(list[index]);
      },
    );
  }

  Widget buildItemBin(List<PickBatchRtv> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBinCheckRtv(item, list[index]);
      },
    );
  }
}
