import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_header.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_bin/stock_counting_bin_screen.dart';
import 'package:msi_app/screens/stock_counting_check/stock_counting_check.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/item_detail_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockCountingItemScreen extends StatelessWidget {
  static const routeName = '/stock_counting_item';

  Future<void> refreshData(BuildContext context, String pickNumber) async {
    final pickItemProvider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    await pickItemProvider.getScDetailByDocNum(pickNumber);

    final pickWhsProvider =
        Provider.of<StockCountingHeaderProvider>(context, listen: false);
    pickWhsProvider.selected.pickItemList = pickItemProvider.item;
  }

  @override
  Widget build(BuildContext context) {
    final item =
        Provider.of<StockCountingHeaderProvider>(context, listen: false).selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Counting'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              authProvider.clearBin();
              Navigator.of(context).pushNamed(StockCountingCheckScreen.routeName);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Inventory Count No', item.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Counting Date', convertDate(item.pickDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Counter Assign', authProvider.username),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Warehouse Name', authProvider.warehouseName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, StockCountingHeader item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.pickNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.pickNumber),
            child: Consumer<StockCountingItemProvider>(
              builder: (_, provider, child) => provider.item.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.item.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.item[index],
                          child: ItemDetailSc(provider.item[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    return InputScan(
      label: 'Item Code',
      hint: 'Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        Navigator.of(context)
            .pushNamed(StockCountingBinScreen.routeName, arguments: item);
      },
    );
  }
}
