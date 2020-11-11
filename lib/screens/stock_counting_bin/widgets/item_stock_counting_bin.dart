import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStockCountingBin extends StatelessWidget {
  final StockCountingItem pickItemReceive;
  final StockCountingBin item;

  const ItemStockCountingBin(this.pickItemReceive, this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        // if (pickItemReceive.fgBatch == 'Y') {
        //   Navigator.of(context).pushNamed(
        //     StockCountingBinScreen.routeName,
        //     arguments: {
        //       'pickItemReceive': pickItemReceive,
        //       'pickListBin': item,
        //     },
        //   );
        // } else {
          // update bin location
          pickItemReceive.itemStorageLocation = item.binLocation;
          Navigator.of(context).popUntil(
              ModalRoute.withName(StockCountingItemScreen.routeName));
        // }
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(kTiny)),
            BaseTextLine('Bin Location', item.binLocation),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            SizedBox(height: getProportionateScreenHeight(kTiny)),
            // BaseTextLine('Qty', item.avlQty.toString()),
          ],
        ),
      ),
    );
  }
}
