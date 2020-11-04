import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_rtv_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_item_rtv/inventory_dispatch_item_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchDetailRtv extends StatelessWidget {
  final InventoryDispatchDetailRtv item;

  const ItemInventoryDispatchDetailRtv(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final inventoryDispatchDetailProvider =
        Provider.of<InventoryDispatchDetailRtvProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        inventoryDispatchDetailProvider.selectPickList(item);
        Navigator.of(context).pushNamed(InventoryDispatchItemRtvScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Doc Number', item.docNumber),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            BaseTextLine('Card Code', item.cardCode),
            BaseTextLine('Card Name', item.cardName),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}
