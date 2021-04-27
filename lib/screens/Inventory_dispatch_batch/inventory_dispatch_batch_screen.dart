import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/inventory_dispatch_bin.dart';
import 'package:msi_app/models/inventory_dispatch_item.dart';
import 'package:msi_app/providers/inventory_dispatch_batch_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_header_provider.dart';
import 'package:msi_app/providers/inventory_dispatch_item_provider.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch/widget/dialog_inventory_dispatch_batch.dart';
import 'package:msi_app/screens/Inventory_dispatch_batch/widget/item_inventory_dispatch_batch.dart';
import 'package:msi_app/screens/inventory_dispatch_item/inventory_dispatch_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class InventoryDispatchBatchScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
  ) async {
    final provider =
        Provider.of<InventoryDispathBatchProvider>(context, listen: false);
    final providerBinHeader =
        Provider.of<InventoryDispatchHeaderProvider>(context, listen: false);
    final providerDetail =
        Provider.of<InventoryDispatchDetailProvider>(context, listen: false);
    final binHeader = providerBinHeader.selected;
    final details = providerDetail.selected;
    await provider.getPlBatchByItemWhs(
        itemCode, binHeader.binCode, details.docNumber);
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###.0000#', 'en_US');

    // final provider =
    //     Provider.of<InventoryDispatchHeaderProvider>(context, listen: false);
    
    final pickItemProvider =
        Provider.of<InventoryDispatchItemProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<InventoryDispathBatchProvider>(context, listen: false);
    Map map = ModalRoute.of(context).settings.arguments;
    InventoryDispatchItem pickItem = map['inventoryDispatchItem'];
    InventoryDispatchBin itemBin = map['inventoryDispatchBin'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              // update bin location
              pickItem.itemStorageLocation = itemBin.binLocation;
              // add batch list
              final batchList = pickBatchProvider.pickedItems;
              pickItemProvider.addBatchList(pickItem, batchList);

              // var guider =
              //     double.tryParse(pickItem.openQty.toStringAsFixed(2)) >
              //             double.tryParse(itemBin.avlQty.toStringAsFixed(2))
              //         ? double.tryParse(itemBin.avlQty.toStringAsFixed(2))
              //         : double.tryParse(pickItem.openQty.toStringAsFixed(2));

              // pickBatchProvider.totalPicked.toStringAsFixed(2) == '0.00'
              //     ? showAlertOnZero(context)
              //     : double.tryParse(pickBatchProvider.totalPicked
              //                 .toStringAsFixed(2)) >
              //             guider
              //         ? showAlertGreaterThanZero(context, guider.toString())
              //         : Navigator.of(context).popUntil(ModalRoute.withName(
              //             InventoryDispatchItemScreen.routeName));
              Navigator.of(context).popUntil(ModalRoute.withName(
                          InventoryDispatchItemScreen.routeName));
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
                Consumer<InventoryDispathBatchProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Picked',provider.totalPicked == 0.0
                  ? provider.totalPicked.toStringAsFixed(4)
                  : formatter.format(provider.totalPicked),
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
            BaseTextLine(
                'Total to Pick Qty', pickItem.openQty == 0.0
                  ? pickItem.openQty.toStringAsFixed(4)
                  :formatter.format(pickItem.openQty)),
            BaseTextLine('UoM', pickItem.unitMsr),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, pickItem, itemBin),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(
    BuildContext context,
    InventoryDispatchItem pickItem,
    InventoryDispatchBin itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<InventoryDispathBatchProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child:
                            ItemInventoryDispatchBatch(provider.items[index]),
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
        Provider.of<InventoryDispathBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInventoryDispatchBatch(item),
        );
      },
    );
  }

  Future<void> showAlertOnZero(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, color: Colors.red, size: 50),
              Divider(),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Please Select at Least 1 Batch Item'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showAlertGreaterThanZero(
      BuildContext context, String toPick) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, color: Colors.red, size: 50),
              Divider(),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Total Picked must be less than or equal to ' + toPick),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
