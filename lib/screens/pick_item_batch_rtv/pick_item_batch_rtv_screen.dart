import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/models/pick_list_bin_rtv.dart';
import 'package:msi_app/providers/pick_batch_rtv_provider.dart';
import 'package:msi_app/providers/pick_item_receive_rtv_provider.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/widget/dialog_pick_batch_rtv.dart';
import 'package:msi_app/screens/pick_item_batch_rtv/widget/item_pick_batch_rtv.dart';
import 'package:msi_app/screens/pick_item_receive_rtv/pick_item_receive_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickItemBatchRtvScreen extends StatelessWidget {
  static const routeName = '/pick_item_batch_Rtv';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider = Provider.of<PickBatchRtvProvider>(context, listen: false);
    await provider.getPlBatchByItemWhs(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickItemProvider =
        Provider.of<PickItemReceiveRtvProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<PickBatchRtvProvider>(context, listen: false);
    Map map = ModalRoute.of(context).settings.arguments;
    PickItemReceiveRtv pickItem = map['pickItemReceive'];
    PickListBinRtv itemBin = map['pickListBin'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List To Vendor'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              // update bin location
              pickItem.itemStorageLocation = itemBin.binLocation;
              // add batch list
              final batchList = pickBatchProvider.pickedItems;
              pickItemProvider.addBatchList(pickItem, batchList);

              Navigator.of(context).popUntil(
                  ModalRoute.withName(PickItemReceiveRtvScreen.routeName));
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
                Consumer<PickBatchRtvProvider>(
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
            buildItemList(context, pickItem, itemBin),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(
    BuildContext context,
    PickItemReceiveRtv pickItem,
    PickListBinRtv itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode, itemBin.binLocation),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<PickBatchRtvProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemPickBatchRtv(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<PickBatchRtvProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPickBatchRtv(item),
        );
      },
    );
  }
}