import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/providers/item_batch_provider.dart';
import 'package:msi_app/providers/item_bin_provider.dart';
import 'package:msi_app/providers/storage_bin_item_provider.dart';
import 'package:msi_app/screens/staging_item/staging_item_screen.dart';
import 'package:msi_app/screens/storage_bin_item/widgets/item_storage_bin_item.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StorageBinItemScreen extends StatelessWidget {
  static const routeName = '/storage_bin_item';

  Future<void> refreshData(BuildContext context) async {
    final provider =
        Provider.of<StorageBinItemProvider>(context, listen: false);
    await provider.getBinLocList();
  }

  @override
  Widget build(BuildContext context) {
    ItemBin itemBin = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Put Away From Vendor'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Consumer<StorageBinItemProvider>(
              builder: (_, provider, child) {
                String binLoc = provider.recBin ?? '';
                return BaseTextLine('Recommendation Bin', binLoc);
              },
            ),
            // BaseTextLine('Recommendation Bin', ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context, itemBin),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Bin Location'),
                ),
                Text('Show All Bin'),
                Consumer<StorageBinItemProvider>(
                  builder: (_, provider, child) {
                    return Switch(
                      value: provider.showAllBin,
                      onChanged: (value) {
                        provider.toggleStatus();
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(),
            buildItemList(context, itemBin),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ItemBin itemBin) {
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
            child: Consumer<StorageBinItemProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemStorageBinItem(
                            itemBin,
                            provider.items[index],
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context, ItemBin itemBin) {
    final provider =
        Provider.of<StorageBinItemProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findBinByBinCode(value);

        final itemBinProvider =
            Provider.of<ItemBinProvider>(context, listen: false);
        final itemBatchProvider =
            Provider.of<ItemBatchProvider>(context, listen: false);
        // update bin location
        itemBin.binCodeDestination = item.binCode;
        if (itemBin.fgBatch == "Y") {
          final batchList = itemBatchProvider.pickedItems;
          itemBinProvider.addBatchList(itemBin, batchList);
        }

        Navigator.of(context)
            .popUntil(ModalRoute.withName(StagingItemScreen.routeName));
      },
    );
  }
}
