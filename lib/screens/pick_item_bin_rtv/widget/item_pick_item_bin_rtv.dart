import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/models/pick_list_bin_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/pick_item_batch_rtv_screen.dart';
import 'package:msi_app/screens/pick_item_receive_rtv/widgets/dialog_pick_list_nonbatch_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemPickItemBinRtv extends StatelessWidget {
  final PickItemReceiveRtv pickItemReceive;
  final PickListBinRtv item;

  const ItemPickItemBinRtv(this.pickItemReceive, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        if (pickItemReceive.fgBatch == 'Y') {
          pickItemReceive.itemStorageLocation = item.binLocation;
          Navigator.of(context).pushNamed(
            PickItemBatchRtvScreen.routeName,
            arguments: {
              'pickItemReceive': pickItemReceive,
              'pickListBin': item,
            },
          );
        } else {
          // update bin location
          pickItemReceive.itemStorageLocation = item.binLocation;
          // Navigator.of(context).popUntil(
          //     ModalRoute.withName(PickItemReceiveRtvScreen.routeName));

             pickItemReceive.itemStorageLocation = item.binLocation;
             showModalBottomSheet(
                context: context, builder: (_) => DialogPickListNonbatchRtv(pickItemReceive));
        
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
