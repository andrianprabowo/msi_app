import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/utils/constants.dart';

class ItemBatchStaging extends StatelessWidget {
  final ItemBatch item;

  const ItemBatchStaging(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //   Navigator.of(context).pushNamed(PutBinScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Batch Number', item.batchNumber),
            buildRow('Description', item.description),
            buildRow('Qty on Batch', item.availableQty.toStringAsFixed(2)),
            buildRow('Inventory UoM', item.inventoryUom),
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
