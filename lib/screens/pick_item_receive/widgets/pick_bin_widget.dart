import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/providers/pick_item_receive_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class PickBinWidget extends StatelessWidget {
  final PickItemReceive pickItem;
  final PickBatch batch;

  const PickBinWidget(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PickItemReceiveProvider>(context, listen: false);
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
                BaseTitle(batch.bin),
                BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}