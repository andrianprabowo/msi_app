import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/models/put_batch.dart';
import 'package:msi_app/providers/item_bin_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class PutBatchWidget extends StatelessWidget {
  final ItemBin item;
  final PutBatch batch;

  const PutBatchWidget(this.item, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemBinProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeBatchItem(item, batch);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTextLine('Batch Number', batch.batchNo),
                BaseTextLine('Expired Date', convertDate(batch.expiredDate)),
                BaseTextLine('Quantity', batch.putQty.toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
