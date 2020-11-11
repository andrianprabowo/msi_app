import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/staging_bin_si.provider.dart';
import 'package:msi_app/screens/stock_inquiry_detail/stock_inquiry_detail.dart';
import 'package:msi_app/screens/stock_inquiry_header/widgets/item_staging_stock_inquiry.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockInquiryHeaderScreen extends StatelessWidget {
  static const routeName = '/stock_inquiry_header';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<StagingBinSiProvider>(context, listen: false).getBinLoc();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Inquiry Bin'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.list_alt),
          //   onPressed: () {
          //     // Navigator.of(context)
          //     //     .pushNamed(ListPutAwaySubmitedScreen.routeName);
          //   },
          // ),
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
            child: Consumer<StagingBinSiProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemStagingStockInquiry(provider.items[index]),
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
    final provider = Provider.of<StagingBinSiProvider>(context, listen: false);
    return InputScan(
      label: 'Staging Bin',
      hint: 'Input or scan Staging Bin',
      scanResult: (value) {
        final item = provider.findByBinCode(value);
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(StockInquiryDetailScreen.routeName);
      },
    );
  }
}
