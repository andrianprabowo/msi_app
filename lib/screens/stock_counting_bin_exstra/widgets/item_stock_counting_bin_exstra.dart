import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';

class ItemStockCountingBinExstra extends StatelessWidget {
  final StockCountingBin item;
  const ItemStockCountingBinExstra(this.item);

  @override
  Widget build(BuildContext context) {
    // final provider =
    //     Provider.of<StockCountingBinProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        // stockItem.itemStorageLocation = item.binLocation;
        Navigator.of(context)
            .popUntil(ModalRoute.withName(StockCountingItemScreen.routeName));
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine(item.binLocation, ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
          ],
        ),
      ),
    );
  }
}
