import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_item_so.dart';
import 'package:msi_app/providers/inventory_dispatch_batch_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_so_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_so_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_so/widget/dialog_inventory_dispatch_batch_so.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch_so/widget/item_inventory_dispatch_batch_so.dart';
import 'package:msi_app/screens/inventory_dispatch_item_so/inventory_dispatch_item_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBatchSoScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_batch_so';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
  ) async {
    final provider =
        Provider.of<InventoryDispathBatchSoProvider>(context, listen: false);
    final providerBinHeader =
        Provider.of<InventoryDispatchHeaderSoProvider>(context, listen: false);
    final providerDetail =
        Provider.of<InventoryDispatchDetailSoProvider>(context, listen: false);
    final binHeader = providerBinHeader.selected;
    final details = providerDetail.selected;
    await provider.getPlBatchByItemWhs(
        itemCode, binHeader.binCode, details.docNumber);
  }

  @override
  Widget build(BuildContext context) {
    final pickItemProvider =
        Provider.of<InventoryDispatchItemSoProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<InventoryDispathBatchSoProvider>(context, listen: false);
    InventoryDispatchItemSo pickItem =
        ModalRoute.of(context).settings.arguments;
    // InventoryDispatchItemSo pickItem = map['inventoryDispatchItem'];
    // InventoryDispatchBinSo itemBin = map['inventoryDispatchBin'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch Sales Order'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              // update bin location
              // pickItem.itemStorageLocation = itemBin.binLocation;
              // add batch list
              final batchList = pickBatchProvider.pickedItems;
              pickItemProvider.addBatchList(pickItem, batchList);

              Navigator.of(context).popUntil(
                  ModalRoute.withName(InventoryDispatchItemSoScreen.routeName));
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
                Consumer<InventoryDispathBatchSoProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Picked',
                      provider.totalPicked.toStringAsFixed(4),
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
    InventoryDispatchItemSo pickItem,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<InventoryDispathBatchSoProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child:
                            ItemInventoryDispatchBatchSo(provider.items[index]),
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
        Provider.of<InventoryDispathBatchSoProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInventoryDispatchBatchSo(item),
        );
      },
    );
  }
}
