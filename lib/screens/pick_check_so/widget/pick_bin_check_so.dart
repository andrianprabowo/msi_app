import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch_so.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class PickBinCheckSo extends StatelessWidget {
  final PickItemReceiveSo pickItem;
  final PickBatchSo batch;

  const PickBinCheckSo(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    // final provider =
    //     Provider.of<PickItemReceiveSoProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                BaseTitle(batch.bin),
                // BaseTextLine('Batch Number', batch.batchNo),
                // BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine(
                    'Quantity',
                    batch.pickQty == 0.0
                        ? batch.pickQty.toStringAsFixed(4)
                        : formatter.format(batch.pickQty)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
