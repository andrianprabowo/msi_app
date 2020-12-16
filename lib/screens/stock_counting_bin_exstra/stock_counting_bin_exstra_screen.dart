import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/screens/stock_counting_bin_exstra/widgets/item_stock_counting_bin_exstra.dart';
import 'package:msi_app/screens/stock_counting_check/stock_counting_check.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockCountingBinExstraScreen extends StatelessWidget {
  static const routeName = '/stock_counting_bin_exstra';

  

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<StockCountingBinProvider>(context, listen: false).getPlBinList(context);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // StockCountingItem stockCountingItem =
    //     ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Counting Bin'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              authProvider.clearBin();
              Navigator.of(context)
                  .pushNamed(StockCountingCheckScreen.routeName);
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
            BaseTextLine('Warehouse Code', authProvider.warehouseId),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Warehouse Name', authProvider.warehouseName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Staging Bin'),
            Divider(),
            buildItemList(context),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context),
            child: Consumer<StockCountingBinProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemStockCountingBinExstra(provider.items[index]),
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
    final provider = Provider.of<StockCountingBinProvider>(context, listen: false);
    return InputScan(
      label: 'Stock Counting Bin',
      hint: 'Input or scan Stock Counting Bin',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
      provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(StockCountingItemScreen.routeName);
      },
    );
  }
}
