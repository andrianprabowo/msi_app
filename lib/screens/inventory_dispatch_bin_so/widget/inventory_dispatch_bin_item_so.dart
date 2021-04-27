import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_bin_so.dart';
import 'package:msi_app/models/inventory_dispatch_item_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_so_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_so/inventory_dispatch_batch_so_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item_so/inventory_dispatch_item_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBinItemSo extends StatelessWidget {
  final InventoryDispatchItemSo inventoryDispatchItem;
  final InventoryDispatchBinSo item;

  const InventoryDispatchBinItemSo(this.inventoryDispatchItem, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
        onTap: () {
          if (inventoryDispatchItem.fgBatch == 'Y') {
            Navigator.of(context).pushNamed(
              InventoryDispatchBatchSoScreen
                  .routeName, //ddasdasdsadasadasdsadsa
              arguments: {
                'inventoryDispatchItem': inventoryDispatchItem,
                'inventoryDispatchBin': item,
              },
            );
          } else {
            inventoryDispatchItem.itemStorageLocation = item.binLocation;
             final inventoryDispItem =
                Provider.of<InventoryDispatchItemSoProvider>(context,
                    listen: false);
            inventoryDispItem.inputBinNonBatch(inventoryDispatchItem,
                inventoryDispatchItem.itemStorageLocation);
            Navigator.of(context).popUntil(
                ModalRoute.withName(InventoryDispatchItemSoScreen.routeName));
          }
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
        ));
  }
}
