import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header_so.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_so_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_detail_so/inventory_dispatch_detail_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchHeaderSo extends StatelessWidget {
  final InventoryDispatchHeaderSo item;

  const ItemInventoryDispatchHeaderSo(this.item);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<InventoryDispatchHeaderSoProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
       

        Navigator.of(context)
            .pushNamed(InventoryDispatchDetailSoScreen.routeName);
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
