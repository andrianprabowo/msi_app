import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ItemStockCountingBin extends StatelessWidget {
  final StockCountingBin item;

  const ItemStockCountingBin(this.item);
  Widget get status {
    switch (item.status) {
      case 0:
        return Icon(Icons.close, color: Colors.white, size: 48);
        break;
      case 1:
        return Icon(Icons.check, color: Colors.green, size: 48);
        break;
      default:
        return Icon(Icons.help_outline, color: Colors.grey, size: 48);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<StockCountingBinProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        provider.updateStatus(item.binLocation);
        Navigator.of(context).pushNamed(StockCountingItemScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(kSmall)),
            status,
            SizedBox(width: getProportionateScreenWidth(kMedium)),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(kLarge)),
                  BaseTitle(item.binLocation),
                  SizedBox(height: getProportionateScreenHeight(kLarge)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
