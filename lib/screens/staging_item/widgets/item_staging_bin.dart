import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/screens/staging_batch/staging_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStagingBin extends StatelessWidget {
  final ItemBin item;

  const ItemStagingBin(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StagingBatchScreen.routeName,
          arguments: item,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Item Code', item.itemCode),
            BaseTextLine('Item Name', item.itemName),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
