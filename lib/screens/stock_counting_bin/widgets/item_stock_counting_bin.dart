import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/providers/bin_stock_counting_provider.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStockCountingBin extends StatelessWidget {
  final StockCountingBin item;

  const ItemStockCountingBin(this.item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BinStockCountingProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        // Navigator.of(context).pushNamed(InventoryDispatchDetailScreen.routeName);
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
