import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_so_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_item_so/inventory_dispatch_item_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_text_line_list.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchDetailSo extends StatelessWidget {
  final InventoryDispatchDetailSo item;

  const ItemInventoryDispatchDetailSo(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final inventoryDispatchDetailProvider =
        Provider.of<InventoryDispatchDetailSoProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        inventoryDispatchDetailProvider.selectPickList(item);
        Navigator.of(context).pushNamed(InventoryDispatchItemSoScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('SO Number', item.docNumber),
            BaseTextLine('SO Date', convertDate(item.docDate)),
            BaseTextLine('Cust Code', item.cardCode),
            BaseTextLineList('Cust Name', item.cardName, 265),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}
