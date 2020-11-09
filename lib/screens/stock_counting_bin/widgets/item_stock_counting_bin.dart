import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_bin.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/bin_stock_counting_provider.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStockCountingBin extends StatelessWidget {
  final StockCountingBin item;
  // final StockCountingHeader itemsHeader;

  const ItemStockCountingBin(this.item );

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<BinStockCountingProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // final poProvider =
    //     Provider.of<StockCountingHeaderProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.selectStagingBin(item);
        // poProvider.selectPo(itemsHeader);

        Navigator.of(context).pushNamed(StockCountingItemScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine(item.binCode, ''),
            SizedBox(height: getProportionateScreenHeight(kSmall)),
            BaseTextLine(authProvider.warehouseName, ''),
          ],
        ),
      ),
    );
  }
}
