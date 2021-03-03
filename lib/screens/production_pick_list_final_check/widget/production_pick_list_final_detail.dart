import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/screens/production_pick_list_final_check/widget/production_pick_list_final_detail_batch.dart';
import 'package:msi_app/screens/production_pick_list_final_check/widget/production_widget_bin_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionPickListFinalDetail extends StatelessWidget {
  final ProductionPickListItemModel item;

  const ProductionPickListFinalDetail(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
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
              'Total to Pick Qty',
              item.openQty == 0.0
                  ? item.openQty.toStringAsFixed(4)
                  : formatter.format(item.openQty)),
          // BaseTextLine(
          //     'Pick Quantity',
          //     item.pickedQty == 0.0
          //         ? item.pickedQty.toStringAsFixed(4)
          //         : formatter.format(item.pickedQty)),
          BaseTextLine('Pick Quantity', item.pickedQty.toStringAsFixed(4)),
          BaseTextLine('Remaining Quantity', item.quantity.toStringAsFixed(4)),
          BaseTextLine('Item Batch', item.fgBatch),
          BaseTextLine('UoM', item.unitMsr),
          BaseTextLine('Bin Location', item.itemStorageLocation),
          Divider(),
          // if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          // buildItemBatchList(item.batchList),
          if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
          if (item.fgBatch == 'N') buildItemBin(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionPickListItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionPickListFinalDetailBatch(list[index]);
      },
    );
  }

  Widget buildItemBin(List<ProductionPickListItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionWidgetBinCheck(item, list[index]);
      },
    );
  }
}
