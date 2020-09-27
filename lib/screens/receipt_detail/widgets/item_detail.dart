import 'package:flutter/material.dart';
import 'package:msi_app/models/item.dart';
import 'package:msi_app/utils/constants.dart';

class ItemDetail extends StatelessWidget {
  final Item item;

  const ItemDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Item Code', item.itemCode),
            buildRow('Item Name', item.itemName),
            buildRow('Total Receipt', item.totalReceipt.toStringAsFixed(2)),
            buildRow('Receipt Qty', item.totalReceipt.toStringAsFixed(2)),
            buildRow('Remaining Qty', item.totalReceipt.toStringAsFixed(2)),
            buildRow('UoM', item.uom),
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
