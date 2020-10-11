import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemPickItemBin extends StatelessWidget {
  final PickListBin item;

  const ItemPickItemBin(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        // Navigator.of(context);
        // .pushNamed(PickItemReceiveScreen.routeName, arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location', item.binLocation),
            BaseTextLine('Capacity', item.capacity.toStringAsPrecision(2)),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            BaseTextLine('Qty', item.qty.toString()),
          ],
        ),
      ),
    );
  }
}
