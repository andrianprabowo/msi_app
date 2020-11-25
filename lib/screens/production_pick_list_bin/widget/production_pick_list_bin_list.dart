import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_bin_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/screens/production_pick_list_item/production_pick_list_item_screen.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/production_pick_list_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionPickListBinList extends StatelessWidget {
  final ProductionPickListItemModel productionPickListItemModel;
  final ProductionPickListBinModel item;

  const ProductionPickListBinList(this.productionPickListItemModel, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final pickItemListProvider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    return InkWell(
      onTap: () {
        if (productionPickListItemModel.fgBatch == "Y") {
          Navigator.of(context).pushNamed(
            ProductionPickListItemBatch.routeName,
            arguments: {
              'productionPickListItemModel': productionPickListItemModel,
              'pickListBin': item,
            },
          );
        } else {
          pickItemListProvider.updateQtyNBinNonBatch(
              productionPickListItemModel,
              double.parse(productionPickListItemModel.pickedQty.toString()),
              item.binLocation);
          Navigator.of(context)
              .popUntil(ModalRoute.withName(ProductionPickListItem.routeName));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location', item.binLocation),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            BaseTextLine(
                'Qty',
                item.avlQty == 0.0
                    ? item.avlQty.toStringAsFixed(4)
                    : formatter.format(item.avlQty)),
          ],
        ),
      ),
    );
  }
}
