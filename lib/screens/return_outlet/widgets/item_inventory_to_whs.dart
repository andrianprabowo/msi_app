import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_to_whs.dart';
import 'package:msi_app/utils/constants.dart';

class ItemInventoryToWhs extends StatelessWidget {
  final InventoryToWhs item;

  const ItemInventoryToWhs(this.item);

  String get dateString {
    return DateFormat.yMMMMd().format(item.docDate);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed(StagingItemScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Doc Number', item.docNumber),
            buildRow('Doc Date', dateString),
            buildRow('From Outlet', item.outlet),
            buildRow('Memo', item.memo),
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
