import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_bin.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_item/production_receipt_rm_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemProdRmBin extends StatelessWidget {
  final ProductionReceiptRMItemListModel pickItemReceive;
  final ProductionReceiptRmBin item;

  const ItemProdRmBin(this.pickItemReceive, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        // if (pickItemReceive.fgBatch == 'Y')
        //   // Navigator.of(context).pushNamed(
        //   //   ProductionReceiptRMItemBatch.routeName,
        //     // arguments: {
        //     //   'pickItemReceive': pickItemReceive,
        //     //   'pickListBin': item,
        //     // },
        //   // );
           
        // else {
          pickItemReceive.itemStorageLocation = item.binLocation;
          Navigator.of(context)
              .popUntil(ModalRoute.withName(ProductionReceiptRMItem.routeName));
        // }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Bin Location',item.binLocation),
            BaseTextLine('Warehouse',authProvider.warehouseName),
            // BaseTextLine('Qty','0.0000'),
          ],
        ),
      ),
    );
  }
}
