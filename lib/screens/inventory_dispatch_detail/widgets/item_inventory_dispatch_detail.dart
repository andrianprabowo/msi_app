import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_item/inventory_dispatch_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchDetail extends StatelessWidget {
  final InventoryDispatchDetail item;

  const ItemInventoryDispatchDetail(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final inventoryDispatchDetailProvider =
        Provider.of<InventoryDispatchDetailProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        inventoryDispatchDetailProvider.selectPickList(item);
        Navigator.of(context).pushNamed(InventoryDispatchItemScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Pick Number', item.docNumber),
            BaseTextLine('Pick Date', convertDate(item.docDate)),
            BaseTextLine('Outlet Code', item.cardCode),
            BaseTextLine('Outlet Name', item.cardName),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}
