import 'package:flutter/material.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_so_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_detail_so/widgets/item_inventory_dispatch_detail_so.dart';
import 'package:msi_app/screens/inventory_dispatch_item_so/inventory_dispatch_item_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchDetailSoScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_detail_so';

  Future<void> refreshData(BuildContext context) async {
    final headerProvider =
        Provider.of<InventoryDispatchHeaderSoProvider>(context, listen: false);
    final provider =
        Provider.of<InventoryDispatchDetailSoProvider>(context, listen: false);
    final item = headerProvider.selected;
    print(item);
    // provider.getPlByWarehouse('WMSISTPR-SYSTEM-BIN-LOCATION');
    provider.getPlByWarehouse(item.binCode);
    print('object$item');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch Sales Order'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.list_alt),
          //   onPressed: () {
          //     // Navigator.of(context)
          //     //     .pushNamed(ListReceiptFromVendorScreen.routeName);
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
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('Inventory Dispatch List'),
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
            child: Consumer<InventoryDispatchDetailSoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemInventoryDispatchDetailSo(
                              provider.items[index]),
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
    final provider =
        Provider.of<InventoryDispatchDetailSoProvider>(context, listen: false);
    return InputScan(
      label: 'Inventory Dispatch',
      hint: 'Input or scan Inventory Dispatch',
      scanResult: (value) {
        final item = provider.findByDocNumber(value);
        provider.selectPickList(item);
        Navigator.of(context).pushNamed(InventoryDispatchItemSoScreen.routeName);
      },
    );
  }
}
