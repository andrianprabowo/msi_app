import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/widget/production_pick_list_item_batch_dialog.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/widget/production_pick_list_item_expired_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionPickListItemBatchList extends StatelessWidget {
  final ProductionPickListItemBatchModel item;
  final ProductionPickListItemModel itemRec;

  const ProductionPickListItemBatchList(this.item, this.itemRec);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        final date = new DateTime.now();

        if (item.expiredDate.isAfter(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => ProductionPickListItemBatchDialog(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => ProductionPickListItemExpired(item),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(itemRec.itemStorageLocation),
            BaseTextLine('Batch No', item.batchNo),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(4)
                    : formatter.format(item.availableQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine('UOM', item.uom),
            BaseTextLine(
                'Picked Qty',
                item.pickQty == 0.0
                    ? item.pickQty.toStringAsFixed(4)
                    : formatter.format(item.pickQty)),
          ],
        ),
      ),
    );
  }
}
