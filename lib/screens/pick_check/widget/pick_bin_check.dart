import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
class PickBinCheck extends StatelessWidget {
  final PickItemReceive pickItem;
  final PickBatch batch;

  const PickBinCheck(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    // final provider =
    //     Provider.of<PickItemReceiveProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
         
          Expanded(
            child: Column(
              children: [
                BaseTitle( batch.bin),
                // BaseTextLine('Batch Number', batch.batchNo),
                // BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine('Quantity', formatter.format(batch.pickQty)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
