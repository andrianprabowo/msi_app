import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin.dart';
import 'package:msi_app/providers/item_bin_provider.dart';
import 'package:msi_app/providers/staging_bin.provider.dart';
import 'package:msi_app/screens/staging_batch/staging_batch_screen.dart';
import 'package:msi_app/screens/staging_item/widgets/item_staging_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StagingItemScreen extends StatelessWidget {
  static const routeName = '/staging_item';

  Future<void> refreshData(BuildContext context, String binCode) async {
    await Provider.of<ItemBinProvider>(context, listen: false)
        .getItemInStagingBin(binCode);
  }

  @override
  Widget build(BuildContext context) {
    final stagingBin =
        Provider.of<StagingBinProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('Put Away'),
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

  Widget buildItemList(BuildContext context, StagingBin item) {
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
            child: Consumer<ItemBinProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemStagingBin(provider.items[index]),
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
    final provider = Provider.of<ItemBinProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        Navigator.of(context).pushNamed(
          StagingBatchScreen.routeName,
          arguments: item,
        );
      },
    );
  }
}
