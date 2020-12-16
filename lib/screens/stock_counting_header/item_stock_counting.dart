import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_header.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/screens/stock_counting_bin/stock_counting_bin_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStockCounting extends StatelessWidget {
  final StockCountingHeader item;

  const ItemStockCounting(this.item);

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<StockCountingHeaderProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        poProvider.selectPo(item);
        Navigator.of(context).pushNamed(StockCountingBinScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Inv.Counting No', item.pickNumber),
            BaseTextLine('Count Date', convertDate(item.pickDate)),
            BaseTextLine('Counter Assign', item.cardCode),
            BaseTextLine('Warehouse', item.cardName)
          ],
        ),
      ),
    );
  }
}
