import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
class ProductionWidgetBinCheck extends StatelessWidget {
  final ProductionPickListItemModel pickItem;
  final ProductionPickListItemBatchModel batch;

  const ProductionWidgetBinCheck(this.pickItem, this.batch);

  @override
  Widget build(BuildContext context) {
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
                BaseTextLine('Quantity', batch.pickQty.toStringAsFixed(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
