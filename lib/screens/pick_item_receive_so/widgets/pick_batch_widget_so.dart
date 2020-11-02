import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch_so.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/providers/pick_item_receive_so_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class PickBatchWidgetSo extends StatelessWidget {
  final PickItemReceiveSo pickItem;
  final PickBatchSo batch;

  const PickBatchWidgetSo(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PickItemReceiveSoProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatchItem(pickItem, batch);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', batch.batchNo),
                BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
