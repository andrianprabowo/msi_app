import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_item_batch_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/screens/production_pick_list_bin/production_pick_list_bin_screen.dart';
import 'package:msi_app/screens/production_pick_list_item/widgets/pick_bin_widget.dart';
import 'package:msi_app/screens/production_pick_list_item/widgets/production_pick_list_item_batch_box.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionPickListItemList extends StatelessWidget {
  final ProductionPickListItemModel item;

  const ProductionPickListItemList(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        item.fgBatch == "Y"
            ? Navigator.of(context)
                .pushNamed(ProductionPickListBin.routeName, arguments: item)
            // : showModalBottomSheet(
            //     context: context,
            //     builder: (_) => ProductionPickListItemNonBatchDialog(item));
            : Navigator.of(context)
                .pushNamed(ProductionPickListBin.routeName, arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.description),
            Divider(),
            BaseTextLine('Total To Pick', formatter.format(item.openQty)),
            BaseTextLine('Picked Qty', item.pickedQty.toStringAsFixed(4)),
            BaseTextLine('Remaining Qty', formatter.format(item.quantity)),
            BaseTextLine('UOM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            // if (item.itemStorageLocation.isNotEmpty)
            //   BaseTextLine('Bin Location', item.itemStorageLocation),
            // //if (item.pickedQty != 0)
            // BaseTextLine(
            //     'Picked Qty',
            //     item.pickedQty == 0.0
            //         ? item.pickedQty.toStringAsFixed(4)
            //         : formatter.format(item.pickedQty)),
            if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
            if (item.fgBatch == 'N') buildItemBin(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<ProductionPickListItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionPickListItemBatchBox(item, list[index]);
      },
    );
  }

  Widget buildItemBin(List<ProductionPickListItemBatchModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBinWidget(item, list[index]);
      },
    );
  }
}
