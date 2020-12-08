import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class AddItemList extends StatelessWidget {
  final StockCountingBin itemBin;
  final StockCountingItem itemList;

  const AddItemList(this.itemBin, this.itemList);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<StockCountingBinProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.removeNewItem(itemBin, itemList);
            },
          ),
          Expanded(
            child: Column(
              children: [
                BaseTitle(itemList.itemCode),
                BaseTitle(itemList.description),
                Divider(),
                BaseTextLine('Counted Qty', itemList.quantity.toStringAsFixed(2)),
                BaseTextLine('Inventory UoM', itemList.unitMsr),
                BaseTextLine('Item Batch', itemList.fgBatch),
                if (itemList.itemStorageLocation.isNotEmpty)
                  BaseTextLine('Bin Location', itemList.itemStorageLocation),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
