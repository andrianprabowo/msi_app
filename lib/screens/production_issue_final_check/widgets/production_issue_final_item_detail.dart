import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/screens/production_issue_final_check/widgets/production_issue_final_item_detail_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionIssueFinalItemDetail extends StatelessWidget {
  final ProductionIssueItemModel item;

  const ProductionIssueFinalItemDetail(this.item);

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
          BaseTitle(item.itemName),
          Divider(),
          BaseTextLine(
              'Available Quantity',
              item.availableQty == 0.0
                  ? item.availableQty.toStringAsFixed(4)
                  : formatter.format(item.availableQty)),
          BaseTextLine('UOM', item.unitMsr),
          BaseTextLine(
              'Put Quantity',
              item.putQty == 0.0
                  ? item.putQty.toStringAsFixed(4)
                  : formatter.format(item.putQty)),
          Divider(),
          if (item.batchList.isNotEmpty) BaseTitle('Item Batch List'),
          buildItemBatchList(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionIssueItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionIssueFinalItemDetailBatch(list[index]);
      },
    );
  }
}
