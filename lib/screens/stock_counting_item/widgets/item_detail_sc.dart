import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/stock_counting_batch.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_batch/stock_counting_batch_screen.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_non_batch_sc.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/item_batch_widget_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ItemDetailSc extends StatelessWidget {
  final StockCountingItem item;

  const ItemDetailSc(this.item);

  @override
  Widget build(BuildContext context) {
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final provider =
        Provider.of<StockCountingItemProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        if (item.fgBatch == 'Y') {
          // print("BATCH");
          // Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamed(StockCountingBatchScreen.routeName, arguments: item);
        } else {
          // print("NON-BATCH");
          showModalBottomSheet(
              context: context, builder: (_) => DialogInputQtyNonBatchSc(item));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        // child: Column(
        //   children: [
        //     IconButton(
        //     icon: Icon(Icons.delete, color: Colors.red),
        //     onPressed: () {
        //       provider.removeItem(item);
        //     },
        //   ),
        //     BaseTitle(item.itemCode),
        //     BaseTitle(item.description),
        //     Divider(),
        //     BaseTextLine('Counted Qty', item.quantity.toStringAsFixed(4)),
        //     BaseTextLine('Inventory UoM', item.unitMsr),
        //     BaseTextLine('Item Batch', item.fgBatch),
        //     if (item.itemStorageLocation.isNotEmpty)
        //       BaseTextLine('Bin Location', ''),
        //     if (item.itemStorageLocation.isNotEmpty)
        //       BaseTextLine('', item.itemStorageLocation),
        //     buildItemBatchList(item.batchList),
        //   ],
        // ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                provider.removeItem(item);
              },
            ),
            Expanded(
              child: Column(
                children: [
                  BaseTitle(item.itemCode),
                  BaseTitle(item.description),
                  Divider(),
                  BaseTextLine(
                      'Counted Qty',
                      item.quantity == 0.0
                          ? item.quantity.toStringAsFixed(authProvider.decLen)
                          : formatter.format(item.quantity)),
                  BaseTextLine('Inventory UoM', item.unitMsr),
                  BaseTextLine('Item Batch', item.fgBatch),
                  if (item.itemStorageLocation.isNotEmpty)
                    BaseTextLine('Bin Location', ''),
                  if (item.itemStorageLocation.isNotEmpty)
                    BaseTextLine('', item.itemStorageLocation),
                  buildItemBatchList(item.batchList),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<StockCountingBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ItemBatchWidgetSc(item, list[index]);
      },
    );
  }
}
