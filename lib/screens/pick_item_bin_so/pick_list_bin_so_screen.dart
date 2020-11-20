import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/providers/pick_list_bin_so_provider.dart';
import 'package:msi_app/providers/pick_list_whs_so_provider.dart';
import 'package:msi_app/screens/pick_item_batch_so/pick_item_batch_so_screen.dart';
import 'package:msi_app/screens/pick_item_bin_so/widget/item_pick_item_bin_so.dart';
import 'package:msi_app/screens/pick_item_receive_so/pick_item_receive_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickListBinSoScreen extends StatelessWidget {
  static const routeName = '/pick_list_bin_so';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    final pickItemProvider =
        Provider.of<PickListBinSoProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickList =
        Provider.of<PickListWhsSoProvider>(context, listen: false).selected;
    PickItemReceiveSo pickItemReceive = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List Sales Order'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<PickListBinSoProvider>(
              builder: (_, provider, child) {
                String binLoc = provider.recBin ?? '';
                return BaseTextLine('Recommendation Bin', binLoc);
              },
            ),
            // BaseTextLine('Recommendation Bin', ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Memo', pickList.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context, pickItemReceive),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Bin Location'),
                ),
                Text('Show All Bin'),
                Consumer<PickListBinSoProvider>(
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
            buildItemList(context, pickItemReceive),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, PickItemReceiveSo item) {
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
            child: Consumer<PickListBinSoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemPickItemBinSo(item, provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context, PickItemReceiveSo pickItemReceive) {
    final provider = Provider.of<PickListBinSoProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
        if (pickItemReceive.fgBatch == 'Y') {
          Navigator.of(context).pushNamed(
            PickItemBatchSoScreen.routeName,
            arguments: {
              'pickItemReceive': pickItemReceive,
              'pickListBin': item,
            },
          );
        } else {
          pickItemReceive.itemStorageLocation = item.binLocation;
          Navigator.of(context)
              .popUntil(ModalRoute.withName(PickItemReceiveSoScreen.routeName));
        }
      },
    );
  }
}
