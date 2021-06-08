import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/stock_counting_batch_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_qty_batch.dart';
import 'package:msi_app/screens/stock_counting_batch/widget/item_stock_counting_batch_sc.dart';
import 'package:msi_app/screens/stock_counting_check/stock_counting_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

import 'widget/dialog_pick_batch_sc.dart';

class StockCountingBatchScreen extends StatelessWidget {
  static const routeName = '/stock_counting_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider =
        Provider.of<StockCountingBatchProvider>(context, listen: false);
    await provider.getPlBatchByItemWhs(context, itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickItemProvider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<StockCountingBatchProvider>(context, listen: false);
    StockCountingItem item = ModalRoute.of(context).settings.arguments;

    // Map map = ModalRoute.of(context).settings.arguments;
    // StockCountingItem pickItem = map['batchList'];
    // StockCountingBin itemBin = map['pickListBin'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Counting'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              //update bin location
              // pickItem.itemStorageLocation = itemBin.binLocation;
              //add batch list
              final batchList = pickBatchProvider.pickedItems;
              final total = pickBatchProvider.totalPicked;
              // print('item => $item');
              // print('batchList => $batchList');
              // print('totalPicked => $total');

              pickItemProvider.addBatch(item, batchList);
              pickItemProvider.inputQty(item, total, context);

              // Navigator.of(context).popUntil(
              //     ModalRoute.withName(StockCountingItemScreen.routeName));
              Navigator.of(context)
                  .pushNamed(StockCountingCheckScreen.routeName);
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
                Consumer<StockCountingBatchProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      ' ', '',
                      // provider.totalPicked.toStringAsFixed(4),
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
            Row(
              children: [
                Consumer<StockCountingBatchProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTitle(
                      'Add Batch',
                    ),
                  );
                }),
                SizedBox(width: getProportionateScreenWidth(kLarge)),
                FlatButton.icon(
                    onPressed: () {
                      // Navigator.of(context).pop();

                      showModalBottomSheet(
                          context: context,
                          builder: (_) => DialogInputQtyBatch(item));
                    },
                    icon: Icon(Icons.add_circle_outline),
                    color: Colors.green,
                    label: Text('New Batch'))
              ],
            ),
            BaseTitle(item.itemCode),
            BaseTitle(item.description),
            BaseTextLine('Uom',item.unitMsr),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, StockCountingItem pickItem) {
    return Expanded(
      child: FutureBuilder(
        future:
            fetchData(context, pickItem.itemCode, pickItem.itemStorageLocation),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<StockCountingBatchProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemStockCountingBatch(provider.items[index]),
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
        Provider.of<StockCountingBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          // builder: (_) => ItemStockCountingBatch(item),
          builder: (_) => DialogPickBatchSc(item),
        );
      },
    );
  }
}
