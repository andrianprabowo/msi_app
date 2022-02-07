import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_batch_rtv.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_item_receive_rtv_provider.dart';
import 'package:msi_app/screens/pick_item_bin_rtv/pick_list_bin_rtv_screen.dart';
import 'package:msi_app/screens/pick_item_receive_rtv/widgets/pick_batch_widget_rtv.dart';
import 'package:msi_app/screens/pick_item_receive_rtv/widgets/pick_bin_widget_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ItemPickReceiveRtv extends StatelessWidget {
  final PickItemReceiveRtv item;

  const ItemPickReceiveRtv(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final provider =
        Provider.of<PickItemReceiveRtvProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectItem(item);

        item.fgBatch == 'Y'
            ? Navigator.of(context)
                .pushNamed(PickListBinRtvScreen.routeName, arguments: item)
            : Navigator.of(context)
                .pushNamed(PickListBinRtvScreen.routeName, arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTitle(item.itemCode),
            BaseTitle(item.description),
            Divider(),
            BaseTextLine(
                'Total To Pick',
                item.openQty == 0.0
                    ? item.openQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.openQty)),
            BaseTextLine(
                'Picked Qty',
                item.pickedQty == 0.0
                    ? item.pickedQty.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.pickedQty)),
            BaseTextLine(
                'Remaining Qty',
                item.quantity == 0.0
                    ? item.quantity.toStringAsFixed(authProvider.decLen)
                    : formatter.format(item.quantity)),
            BaseTextLine('Inventory UoM', item.unitMsr),
            BaseTextLine('Item Batch', item.fgBatch),
            if (item.fgBatch == 'Y') buildItemBatchList(item.batchList),
            if (item.fgBatch == 'N') buildItemBin(item.batchList),
          ],
        ),
      ),
    );
  }

  Widget buildItemBatchList(List<PickBatchRtv> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBatchWidgetRtv(item, list[index]);
      },
    );
  }

  Widget buildItemBin(List<PickBatchRtv> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return PickBinWidgetRtv(item, list[index]);
      },
    );
  }
}
