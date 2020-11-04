import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';
import 'package:msi_app/providers/inventory_dispatch_bin_Rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_rtv_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/inventory_dispatch_batch_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_bin_rtv/widget/inventory_dispatch_bin_item_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBinRtvScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_bin_rtv';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    final inventoryDispatchBin =
        Provider.of<InventoryDispatchBinRtvProvider>(context, listen: false);
    await inventoryDispatchBin.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickList =
        Provider.of<InventoryDispatchDetailRtvProvider>(context, listen: false)
            .selected;
    InventoryDispatchItemRtv inventoryDispatchItem =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch RTV'),
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
            buildInputScan(context, inventoryDispatchItem),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Bin Location'),
                ),
                Text('Show All Bin'),
                Consumer<InventoryDispatchBinRtvProvider>(
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
            buildItemList(context, inventoryDispatchItem),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, InventoryDispatchItemRtv item) {
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
            child: Consumer<InventoryDispatchBinRtvProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        print('TESTING');
                        print(provider.items[index]);
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: InventoryDispatchBinItemRtv(
                              item, provider.items[index]),
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
      BuildContext context, InventoryDispatchItemRtv inventoryDispatchItem) {
    final provider =
        Provider.of<InventoryDispatchBinRtvProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
        Navigator.of(context).pushNamed(
          InventoryDispatchBatchRtvScreen.routeName,
          arguments: {
            'inventoryDispatchItem': inventoryDispatchItem,
            'inventoryDispatchBin': item,
          },
        );
      },
    );
  }
}
