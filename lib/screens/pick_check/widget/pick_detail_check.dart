import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/pick_check/widget/pick_batch_check.dart';
import 'package:msi_app/screens/pick_check/widget/pick_bin_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class PickDetailCheck extends StatelessWidget {
  final PickItemReceive item;

  const PickDetailCheck(this.item);

  @override
  Widget build(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    return Container(
      margin: const EdgeInsets.all(kTiny),
      padding: const EdgeInsets.all(kSmall),
      decoration: kBoxDecoration,
      child: Column(
        children: [
          BaseTitle(item.itemCode),
          BaseTitle(item.description),
          Divider(),
          BaseTextLine(
              'Total To Pick Quantity',
              item.openQty == 0.0
                  ? item.openQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.openQty)),
          BaseTextLine(
              'Pick Quantity',
              item.pickedQty == 0.0
                  ? item.pickedQty.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.pickedQty)),
          BaseTextLine(
              'Remaining Quantity',
              item.quantity == 0.0
                  ? item.quantity.toStringAsFixed(authProvider.decLen)
                  : formatter.format(item.quantity)),
          BaseTextLine('Item Batch', item.fgBatch),
          BaseTextLine('UoM', item.unitMsr),
          Divider(),
          if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
          if (item.fgBatch == 'N') buildItemBin(item.batchList),
        ],
      ),
    );
  }

  Widget buildItemBatchList(List<PickBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBatchCheck(list[index]);
      },
    );
  }

  Widget buildItemBin(List<PickBatch> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBinCheck(item, list[index]);
      },
    );
  }
}
