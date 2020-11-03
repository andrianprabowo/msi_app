import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_bin.dart';
import 'package:msi_app/models/inventory_dispatch_item.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch/inventory_dispatch_batch_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item/inventory_dispatch_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBinItem extends StatelessWidget {
  final InventoryDispatchItem inventoryDispatchItem;
  final InventoryDispatchBin item;

  const InventoryDispatchBinItem(this.inventoryDispatchItem, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        inventoryDispatchItem.fgBatch == 'Y'
            ? Navigator.of(context).pushNamed(
                InventoryDispatchBatchScreen.routeName,   //ddasdasdsadasadasdsadsa
                arguments: {
                  'inventoryDispatchItem': inventoryDispatchItem,
                  'inventoryDispatchBin': item,
                },
              )
            : 
             Navigator.of(context).popUntil(
                  ModalRoute.withName(InventoryDispatchItemScreen.routeName));
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location', item.binLocation),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            // BaseTextLine('Qty', item.avlQty.toString()),
          ],
        ),
      )
    );
  }
}
