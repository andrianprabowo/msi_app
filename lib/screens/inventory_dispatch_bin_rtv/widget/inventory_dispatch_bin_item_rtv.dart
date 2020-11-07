import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_bin_rtv.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/inventory_dispatch_batch_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item_rtv/inventory_dispatch_item_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBinItemRtv extends StatelessWidget {
  final InventoryDispatchItemRtv inventoryDispatchItem;
  final InventoryDispatchBinRtv item;

  const InventoryDispatchBinItemRtv(this.inventoryDispatchItem, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
        onTap: () {
          if (inventoryDispatchItem.fgBatch == 'Y') {
            Navigator.of(context).pushNamed(
              InventoryDispatchBatchRtvScreen
                  .routeName, //ddasdasdsadasadasdsadsa
              arguments: {
                'inventoryDispatchItem': inventoryDispatchItem,
                'inventoryDispatchBin': item,
              },
            );
          }else{
          inventoryDispatchItem.itemStorageLocation = item.binLocation;

            Navigator.of(context).popUntil(
              ModalRoute.withName(InventoryDispatchItemRtvScreen.routeName));
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
