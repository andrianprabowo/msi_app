import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/utils/constants.dart';

class ItemPickReceive extends StatelessWidget {
  final PickItemReceive item;

  const ItemPickReceive(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigator.of(context).pushNamed(PickItemReceiveScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(item.itemCode),
            buildTitle(item.dscription),
            Divider(),
            buildRow('Total To Pick', item.openQty.toStringAsFixed(2)),
            buildRow('Remaining Qty', item.quantity.toStringAsFixed(2)),
            buildRow('Inventory UoM', item.unitMsr),
            buildRow('Bin Location', '??????'),
            buildRow('Batch Number', '??????'),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String label) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
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
