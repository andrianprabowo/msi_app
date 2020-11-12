import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/screens/stock_counting_batch/stock_counting_batch_screen.dart';
import 'package:msi_app/screens/stock_counting_bin/widgets/item_stock_counting_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockCountingBinScreen extends StatelessWidget {
  static const routeName = '/stock_counting_bin';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    final pickItemProvider =
        Provider.of<StockCountingBinProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    // final pickList =
    //     Provider.of<StockCountingHeaderProvider>(context, listen: false)
    //         .selected;
    StockCountingItem pickItemReceive =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Counting'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context, pickItemReceive),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            
            Divider(),
            BaseTitle('list Bin Location'),
            buildItemList(context, pickItemReceive),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, StockCountingItem item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.itemCode),
            child: Consumer<StockCountingBinProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child:
                              ItemStockCountingBin(item, provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(
      BuildContext context, StockCountingItem pickItemReceive) {
    final provider =
        Provider.of<StockCountingBinProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
        Navigator.of(context).pushNamed(
          StockCountingBatchScreen.routeName,
          arguments: {
            'pickItemReceive': pickItemReceive,
            'pickListBin': item,
          },
        );
      },
    );
  }
}
