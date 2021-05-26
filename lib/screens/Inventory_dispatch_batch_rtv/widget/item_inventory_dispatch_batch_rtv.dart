import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_dispatch_batch_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/widget/dialog_inventory_dispatch_batch_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchBatchRtv extends StatelessWidget {
  final InventoryDispatchBatchRtv item;

  const ItemInventoryDispatchBatchRtv(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInventoryDispatchBatchRtv(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Batch No', item.batchNo),
            BaseTextLine('Uom', item.uom),
            BaseTextLine(
                'Available Qty',
                item.availableQty == 0.0
                    ? item.availableQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.availableQty)),
            BaseTextLine(
                'Remaining Qty',
                item.remainQty == 0.0
                    ? item.remainQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.remainQty)),
            BaseTextLine('Expired Date', convertDate(item.expiredDate)),
            BaseTextLine(
                'Picked Qty',
                item.pickQty == 0.0
                    ? item.pickQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.pickQty)),
          ],
        ),
      ),
    );
  }
}
