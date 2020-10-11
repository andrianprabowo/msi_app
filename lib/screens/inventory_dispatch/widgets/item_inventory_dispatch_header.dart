import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header.dart';
import 'package:msi_app/providers/inventory_dispatch_header_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_detail/inventory_dispatch_detail_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemInventoryDispatchHeader extends StatelessWidget {
  final InventoryDispatchHeader item;

  const ItemInventoryDispatchHeader(this.item);

  @override
  Widget build(BuildContext context) {
    final invDisHeader =
        Provider.of<InventoryDispatchHeaderProvider>(context, listen: false);

    return InkWell(
      onTap: () async {
        if (invDisHeader.zonation == null) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: getProportionateScreenWidth(kLarge)),
                  Text('Please select Zonation'),
                ],
              ),
            ),
          );
          return;
        }

        invDisHeader.setHeader(item);
        Navigator.of(context)
            .pushNamed(InventoryDispatchDetailScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Doc Number', item.docNumber),
            BaseTextLine('Require Date', convertDate(item.requireDate)),
            BaseTextLine('To Warehouse', item.toWarehouse),
            BaseTextLine('Memo', item.memo),
          ],
        ),
      ),
    );
  }
}
