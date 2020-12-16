import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_batch_rtv.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';
import 'package:msi_app/providers/inventory_dispatch_item_rtv_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBatchWidgetRtv extends StatelessWidget {
  final InventoryDispatchItemRtv pickItem;
  final InventoryDispatchBatchRtv batch;

  const InventoryDispatchBatchWidgetRtv(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<InventoryDispatchItemRtvProvider>(context, listen: false);
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
                BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
