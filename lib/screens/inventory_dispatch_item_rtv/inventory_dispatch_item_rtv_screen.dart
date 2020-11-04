import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail_rtv.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_rtv_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_bin_rtv/inventory_dispatch_bin_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_check_rtv/inventory_dispatch_check_rtv_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_item_rtv/widgets/item_inventory_dispatch_item_rtv.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchItemRtvScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_item_rtv';

  Future<void> refreshData(BuildContext context, String docNumber) async {
    final inventoryItemProvider =
        Provider.of<InventoryDispatchItemRtvProvider>(context, listen: false);
    await inventoryItemProvider.getInventItemByPlNo(docNumber);

    final inventoryDispatchDetailProvider =
        Provider.of<InventoryDispatchDetailRtvProvider>(context, listen: false);
    inventoryDispatchDetailProvider.selected.itemList = inventoryItemProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final item =
        Provider.of<InventoryDispatchDetailRtvProvider>(context, listen: false).selected;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch RTV'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              Navigator.of(context).pushNamed(InventoryDispatchCheckRtvScreen.routeName);
            },
          )
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
            BaseTextLine('Doc Number', item.docNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Remarks', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, InventoryDispatchDetailRtv item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.docNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.docNumber),
            child: Consumer<InventoryDispatchItemRtvProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemInventoryDispatchItemRtv(provider.items[index]),
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
        Provider.of<InventoryDispatchItemRtvProvider>(context, listen: false);
    return InputScan(
      label: 'Item Code',
      hint: 'Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        Navigator.of(context)
            .pushNamed(InventoryDispatchBinRtvScreen.routeName, arguments: item);
      },
    );
  }
}