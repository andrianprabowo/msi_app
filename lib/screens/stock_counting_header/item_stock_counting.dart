import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_header.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemStockCounting extends StatelessWidget {
  final StockCountingHeader item;

  const ItemStockCounting(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider =
        Provider.of<StockCountingHeaderProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        poProvider.selectPo(item);
        Navigator.of(context).pushNamed(StockCountingItemScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Cycle Count No', item.pickNumber),
            BaseTextLine('Count Date', convertDate(item.pickDate)),
            BaseTextLine('Counter Assign', authProvider.username),
            BaseTextLine('Warehouse', authProvider.warehouseName)
          ],
        ),
      ),
    );
  }
}
