import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/providers/pick_list_bin_provider.dart';
import 'package:msi_app/providers/pick_list_whs_provider.dart';
import 'package:msi_app/screens/pick_item_batch/pick_item_batch_screen.dart';
import 'package:msi_app/screens/pick_item_bin/widget/item_pick_item_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickListBinScreen extends StatelessWidget {
  static const routeName = '/pick_list_bin';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    final pickItemProvider =
        Provider.of<PickListBinProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickList =
        Provider.of<PickListWhsProvider>(context, listen: false).selected;
    PickItemReceive pickItemReceive = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Recommendation Bin', ''),
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
                Consumer<PickListBinProvider>(
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

  Widget buildItemList(BuildContext context, PickItemReceive item) {
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
            child: Consumer<PickListBinProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemPickItemBin(item, provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context, PickItemReceive pickItemReceive) {
    final provider = Provider.of<PickListBinProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
        Navigator.of(context).pushNamed(
          PickItemBatchScreen.routeName,
          arguments: {
            'pickItemReceive': pickItemReceive,
            'pickListBin': item,
          },
        );
      },
    );
  }
}
