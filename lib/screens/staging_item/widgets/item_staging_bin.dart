import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/screens/put_batch_screen/put_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';

class ItemStagingBin extends StatelessWidget {
  final ItemBin item;

  const ItemStagingBin(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PutBatchScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Item Code', item.itemCode),
            buildRow('Item Name', item.itemName),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(value)
      ],
    );
  }
}
