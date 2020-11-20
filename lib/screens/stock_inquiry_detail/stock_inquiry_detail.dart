import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin_si.dart';
import 'package:msi_app/providers/item_bin_si_provider.dart';
import 'package:msi_app/providers/staging_bin_si.provider.dart';
import 'package:msi_app/screens/stock_inquiry_batch/stock_inquiry_batch_screen.dart';
import 'package:msi_app/screens/stock_inquiry_detail/widgets/item_staging_bin_si.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockInquiryDetailScreen extends StatelessWidget {
  static const routeName = '/stock_inquiry_detail';

  Future<void> refreshData(BuildContext context, String binCode) async {
    final itemBinProvider =
        Provider.of<ItemBinSiProvider>(context, listen: false);
    await itemBinProvider.getItemInStagingBin(binCode);

    final stagingBinProvider =
        Provider.of<StagingBinSiProvider>(context, listen: false);
    stagingBinProvider.selected.itemBinList = itemBinProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final stagingBin =
        Provider.of<StagingBinSiProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Inquiry Item'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.post_add),
          //   onPressed: () =>
          //       Navigator.of(context).pushNamed(StagingCheckScreen.routeName),
          // )
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
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, stagingBin),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, StagingBinSi item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.binCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.binCode),
            child: Consumer<ItemBinSiProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemStagingBinSi(provider.items[index]),
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
    final provider = Provider.of<ItemBinSiProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        if (item.fgBatch == 'Y')
          Navigator.of(context)
              .pushNamed(StockInquiryBatchScreen.routeName, arguments: item);
      },
    );
  }
}
