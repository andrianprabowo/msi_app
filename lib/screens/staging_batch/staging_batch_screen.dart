import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/providers/item_batch_provider.dart';
import 'package:msi_app/screens/staging_batch/widgets/dialog_put_away.dart';
import 'package:msi_app/screens/staging_batch/widgets/item_batch_staging.dart';
import 'package:msi_app/screens/storage_bin_item/storage_bin_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StagingBatchScreen extends StatelessWidget {
  static const routeName = '/staging_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider = Provider.of<ItemBatchProvider>(context, listen: false);
    await provider.getBatchListByItemWarehouse(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
    final itemBatchProvider =
        Provider.of<ItemBatchProvider>(context, listen: false);
    ItemBin item = ModalRoute.of(context).settings.arguments;
    final avlQty = item.availableQty.toStringAsFixed(4);

    return Scaffold(
      appBar: AppBar(
        title: Text('Put Away From Vendor'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              if (double.parse(itemBatchProvider.totalPicked.toStringAsFixed(4)) >
                  double.parse(item.availableQty.toStringAsFixed(4))) {
                print('Tidak boleh lebih besar dari Available Qty ');
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notification_important,
                              color: Colors.red, size: 50),
                          Divider(),
                          SizedBox(
                              height: getProportionateScreenHeight(kLarge)),
                          BaseTitleColor('Qty must be above 0'),
                          SizedBox(
                              height: getProportionateScreenHeight(kLarge)),
                          BaseTitleColor('or equal to  $avlQty'),
                          SizedBox(
                              height: getProportionateScreenHeight(kLarge)),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
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
              Navigator.of(context).pushNamed(
                StorageBinItemScreen.routeName,
                arguments: item,
              );
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
                Consumer<ItemBatchProvider>(
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
                      itemBatchProvider.clear();
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    label: Text('CLEAR'))
              ],
            ),
            BaseTitle(item.itemCode),
            BaseTitle(item.itemName),
            BaseTextLine('Available Qty', item.availableQty.toStringAsFixed(4)),
            BaseTextLine('Uom', item.uom),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ItemBin item) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, item.itemCode, item.binCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ItemBatchProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemBatchStaging(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ItemBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPutAway(item),
        );
      },
    );
  }
}
