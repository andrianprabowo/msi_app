import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin_rfo.dart';
import 'package:msi_app/providers/item_batch_rfo_provider.dart';
import 'package:msi_app/providers/item_bin_rfo_provider.dart';
import 'package:msi_app/providers/storage_bin_item_rfo_provider.dart';
import 'package:msi_app/screens/staging_item_rfo/staging_item_rfo_screen.dart';
import 'package:msi_app/screens/storage_bin_item_rfo/widgets/item_storage_bin_item_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StorageBinItemRfoScreen extends StatelessWidget {
  static const routeName = '/storage_bin_item_rfo';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    final provider =
        Provider.of<StorageBinItemRfoProvider>(context, listen: false);
    await provider.getBinLocList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    ItemBinRfo itemBin = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Put Away From Outlet'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<StorageBinItemRfoProvider>(
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
                Consumer<StorageBinItemRfoProvider>(
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

  Widget buildItemList(BuildContext context, ItemBinRfo itemBin) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, itemBin.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, itemBin.itemCode),
            child: Consumer<StorageBinItemRfoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemStorageBinItemRfo(
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

  Widget buildInputScan(BuildContext context, ItemBinRfo itemBin) {
    final provider =
        Provider.of<StorageBinItemRfoProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findBinByBinCode(value);

        final itemBinProvider =
            Provider.of<ItemBinRfoProvider>(context, listen: false);
        final itemBatchProvider =
            Provider.of<ItemBatchRfoProvider>(context, listen: false);
        // update bin location
        itemBin.binCodeDestination = item.binCode;
        if (itemBin.fgBatch == "Y") {
          final batchList = itemBatchProvider.pickedItems;
          itemBinProvider.addBatchList(itemBin, batchList);
        }

        Navigator.of(context)
            .popUntil(ModalRoute.withName(StagingItemRfoScreen.routeName));
      },
    );
  }
}
