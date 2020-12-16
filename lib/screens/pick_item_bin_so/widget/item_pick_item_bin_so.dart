import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/models/pick_list_bin_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/pick_item_batch_so/pick_item_batch_so_screen.dart';
import 'package:msi_app/screens/pick_item_receive_so/pick_item_receive_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemPickItemBinSo extends StatelessWidget {
  final PickItemReceiveSo pickItemReceive;
  final PickListBinSo item;

  const ItemPickItemBinSo(this.pickItemReceive, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        if (pickItemReceive.fgBatch == 'Y') {
          Navigator.of(context).pushNamed(
            PickItemBatchSoScreen.routeName,
            arguments: {
              'pickItemReceive': pickItemReceive,
              'pickListBin': item,
            },
          );
        } else {
          pickItemReceive.itemStorageLocation = item.binLocation;
          Navigator.of(context)
              .popUntil(ModalRoute.withName(PickItemReceiveSoScreen.routeName));
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
            BaseTextLine('Qty', item.avlQty.toStringAsFixed(4)),
          ],
        ),
      ),
    );
  }
}
