import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_so_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_detail_so/inventory_dispatch_detail_so_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_so/widgets/item_inventory_dispatch_header_so.dart';
import 'package:msi_app/screens/list_inv_dispatch_so/list_inv_dispatch_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchHeaderSoScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_header_so';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<InventoryDispatchHeaderSoProvider>(context, listen: false).getBinLoc();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch Sales Order'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ListInvDispatchSoScreen.routeName);
            },
          ),
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
            child: Consumer<InventoryDispatchHeaderSoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemInventoryDispatchHeaderSo(provider.items[index]),
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
    final provider = Provider.of<InventoryDispatchHeaderSoProvider>(context, listen: false);
    return InputScan(
      label: 'Staging Bin',
      hint: 'Input or scan Staging Bin',
      scanResult: (value) {
        final item = provider.findByBinCode(value);
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(InventoryDispatchDetailSoScreen.routeName);
      },
    );
  }
}
