import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_batch_list_model.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/screens/production_receipt_rm_item/widgets/production_receipt_rm_item_batch_box.dart';
import 'package:msi_app/screens/production_receipt_rm_item/widgets/production_receipt_rm_item_non_batch_dialog.dart';
import 'package:msi_app/screens/production_receipt_rm_item_batch/production_receipt_rm_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';

class ProductionReceiptRMItemList extends StatelessWidget {
  final ProductionReceiptRMItemListModel item;

  const ProductionReceiptRMItemList(this.item);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');

    return InkWell(
      onTap: () {
        if (item.fgBatch == 'Y') {
          Navigator.of(context).pushNamed(
              ProductionReceiptRMItemBatch.routeName,
              arguments: item);
        } else {
          print('isi nya = $item');
          showModalBottomSheet(
              context: context,
              builder: (_) => ProductionReceiptRMItemNonBatchDialog(item));
        }
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
            BaseTextLine(
                'Total To Receipt',
                item.openQty == 0.0
                    ? item.openQty.toStringAsFixed(4)
                    : formatter.format(item.openQty)),
            BaseTextLine(
                'Remaining Qty',
                item.quantity == 0.0
                    ? item.quantity.toStringAsFixed(4)
                    : formatter.format(item.quantity)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            if (item.itemStorageLocation.isNotEmpty)
              BaseTextLine('Bin Location', item.itemStorageLocation), 
            // if (item.pickedQty != 0)
            BaseTextLine(
                'Picked Qty',
                item.pickedQty == 0.0
                    ? item.pickedQty.toStringAsFixed(4)
                    : formatter.format(item.pickedQty)),
            buildItemBatchList(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(
      List<ProductionReceiptRMItemListBatchListModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ProductionReceiptRMItemBatchBox(item, list[index]);
      },
    );
  }
}
