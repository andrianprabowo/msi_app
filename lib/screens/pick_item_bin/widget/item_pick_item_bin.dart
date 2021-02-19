import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/pick_item_batch/pick_item_batch_screen.dart';
import 'package:msi_app/screens/pick_item_receive/widgets/dialog_pick_list_nonbatch.dart';
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
        if (pickItemReceive.fgBatch == 'Y'){
          pickItemReceive.itemStorageLocation = item.binLocation;
          Navigator.of(context).pushNamed(
            PickItemBatchScreen.routeName,
            arguments: {
              'pickItemReceive': pickItemReceive,
              'pickListBin': item,
            },
          );
        }else {
        //   final pickBatchProvider =
        // Provider.of<PickListBinProvider>(context, listen: false);
          pickItemReceive.itemStorageLocation = item.binLocation;
            //  final binList = pickBatchProvider.itemsSelect;

              // pickItemProvider.addBinList(pickItemReceive, binList);


             showModalBottomSheet(
                context: context, builder: (_) => DialogPickListNonbatch(pickItemReceive));
          // Navigator.of(context)
          //     .popUntil(ModalRoute.withName(PickItemReceiveScreen.routeName));
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
