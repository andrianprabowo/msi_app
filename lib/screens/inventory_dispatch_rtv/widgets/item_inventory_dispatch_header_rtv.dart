import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header_rtv.dart';
import 'package:msi_app/providers/inventory_dispatch_header_Rtv_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_detail_rtv/inventory_dispatch_detail_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchHeaderRtv extends StatelessWidget {
  final InventoryDispatchHeaderRtv item;

  const ItemInventoryDispatchHeaderRtv(this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventoryDispatchHeaderRtvProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(InventoryDispatchDetailRtvScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine(item.binCode, ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
          ],
        ),
      ),
    );
  }
}
