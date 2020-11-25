import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_batch_model.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/screens/production_issue_item/widgets/production_issue_item_batch_box.dart';
import 'package:msi_app/screens/production_issue_item/widgets/production_issue_item_non_batch_dialog.dart';
import 'package:msi_app/screens/production_issue_item_batch/production_issue_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionIssueItemList extends StatelessWidget {
  final ProductionIssueItemModel item;

  const ProductionIssueItemList(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(ProductionIssueItemBatch.routeName, arguments: item)
            : showModalBottomSheet(
                context: context,
                builder: (_) => ProductionIssueItemNonBatchDialog(item));
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.itemName),
            Divider(),
            BaseTextLine('Item Batch', item.fgBatch),
            BaseTextLine('Available Qty', item.availableQty == 0.0
                  ? item.availableQty.toStringAsFixed(4)
                  : formatter.format(item.availableQty)),
            BaseTextLine('UOM', item.unitMsr),
            BaseTextLine('Remaining Qty', item.remainingQty == 0.0
                  ? item.remainingQty.toStringAsFixed(4)
                  : formatter.format(item.remainingQty)),
            if (item.putQty != 0)
              BaseTextLine('Put Qty', item.putQty == 0.0
                  ? item.putQty.toStringAsFixed(4)
                  : formatter.format(item.putQty)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionIssueItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionIssueItemBatchBox(item, list[index]);
      },
    );
  }
}
