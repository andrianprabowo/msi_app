import 'package:flutter/material.dart';
import 'package:msi_app/providers/bin_stock_counting_provider.dart';
import 'package:msi_app/screens/stock_counting_bin/widgets/item_stock_counting_bin.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/item_detail_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockCountingBinScreen extends StatelessWidget {
  static const routeName = '/stock_counting_bin';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<BinStockCountingProvider>(context, listen: false).getAllBinRtv();
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Counting'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              // Navigator.of(context)
              //     .pushNamed(InventoryDispatchDetailScreen.routeName);
            },
          ),
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
            // BaseTextLine('Warehouse Code', authProvider.warehouseId),
            // SizedBox(height: getProportionateScreenHeight(kLarge)),
            // BaseTextLine('Warehouse Name', authProvider.warehouseName),
            // SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Bin Location'),
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
            child: Consumer<BinStockCountingProvider>(
              builder: (_, provider, child) => provider.itemsBins.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.itemsBins.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.itemsBins[index],
                          child: ItemStockCountingBin(provider.itemsBins[index]),
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
    final provider = Provider.of<BinStockCountingProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Input or scan Staging Bin',
      scanResult: (value) {
        final item = provider.findByBinCode(value);
        provider.selectStagingBin(item);
        // Navigator.of(context).pushNamed(InventoryDispatchItemScreen.routeName);
      },
    );
  }
}
