import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class PickBinWidget extends StatelessWidget {
  final ProductionPickListItemModel pickItem;
  final ProductionPickListItemBatchModel batch;

  const PickBinWidget(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
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
                BaseTitle( batch.bin),
                BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}