import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/pick_item_batch/pick_item_batch_screen.dart';
import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemPickItemBin extends StatelessWidget {
  final PickItemReceive pickItemReceive;
  final PickListBin item;

  const ItemPickItemBin(this.pickItemReceive, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        pickItemReceive.fgBatch == 'Y'
            ? Navigator.of(context).pushNamed(
                PickItemBatchScreen.routeName,
                arguments: {
                  'pickItemReceive': pickItemReceive,
                  'pickListBin': item,
                },
              )
            : 
             Navigator.of(context).popUntil(
                  ModalRoute.withName(PickItemReceiveScreen.routeName));
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location', item.binLocation),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            BaseTextLine('Qty', item.avlQty.toString()),
          ],
        ),
      ),
    );
  }
}
