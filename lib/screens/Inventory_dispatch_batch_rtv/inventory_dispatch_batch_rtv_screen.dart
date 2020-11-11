import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_item_rtv.dart';
import 'package:msi_app/providers/inventory_dispatch_batch_rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_Rtv_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_rtv_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/widget/dialog_inventory_dispatch_batch_rtv.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_rtv/widget/item_inventory_dispatch_batch_rtv.dart';
import 'package:msi_app/screens/inventory_dispatch_item_rtv/inventory_dispatch_item_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBatchRtvScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_batch_rtv';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
  ) async {
    final provider =
        Provider.of<InventoryDispathBatchRtvProvider>(context, listen: false);
    final providerBinHeader =
        Provider.of<InventoryDispatchHeaderRtvProvider>(context, listen: false);
    final providerDetail =
        Provider.of<InventoryDispatchDetailRtvProvider>(context, listen: false);
    final binHeader = providerBinHeader.selected;
    final details = providerDetail.selected;
    await provider.getPlBatchByItemWhs(
        itemCode, binHeader.binCode, details.docNumber);
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<InventoryDispatchHeaderRtvProvider>(context, listen: false);
    print("TST SELECTED");
    print(provider.selected);
    final pickItemProvider =
        Provider.of<InventoryDispatchItemRtvProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<InventoryDispathBatchRtvProvider>(context, listen: false);
    InventoryDispatchItemRtv pickItem =
        ModalRoute.of(context).settings.arguments;
    //     Provider.of<InventoryDispathBatchRtvProvider>(context, listen: false);
    // Map map = ModalRoute.of(context).settings.arguments;
    // InventoryDispatchItemRtv pickItem = map['inventoryDispatchItem'];
    // InventoryDispatchBinRtv itemBin = map['inventoryDispatchBin'];
    print("ITEM BIN");
    // print(itemBin);
    print("PICK ITEM");
    print(pickItem);
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch RTV'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              // update bin location
              // pickItem.itemStorageLocation = itemBin.binLocation;
              // add batch list
              final batchList = pickBatchProvider.pickedItems;
              pickItemProvider.addBatchList(pickItem, batchList);

              Navigator.of(context).popUntil(ModalRoute.withName(
                  InventoryDispatchItemRtvScreen.routeName));
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
            buildInputScan(context),
            Row(
              children: [
                Consumer<InventoryDispathBatchRtvProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Picked',
                      provider.totalPicked.toStringAsFixed(2),
                    ),
                  );
                }),
                SizedBox(width: getProportionateScreenWidth(kLarge)),
                FlatButton.icon(
                    onPressed: () {
                      pickBatchProvider.clear();
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    label: Text('CLEAR'))
              ],
            ),
            BaseTitle(pickItem.itemCode),
            BaseTitle(pickItem.description),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, pickItem),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(
    BuildContext context,
    InventoryDispatchItemRtv pickItem,
    // InventoryDispatchBinRtv itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<InventoryDispathBatchRtvProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemInventoryDispatchBatchRtv(
                            provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<InventoryDispathBatchRtvProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInventoryDispatchBatchRtv(item),
        );
      },
    );
  }
}
