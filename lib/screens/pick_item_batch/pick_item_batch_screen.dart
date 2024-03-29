import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_item_receive.dart';
import 'package:msi_app/models/pick_list_bin.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_batch_provider.dart';
import 'package:msi_app/providers/pick_item_receive_provider.dart';
import 'package:msi_app/screens/pick_item_batch/widget/dialog_expired.dart';
import 'package:msi_app/screens/pick_item_batch/widget/dialog_pick_batch.dart';
import 'package:msi_app/screens/pick_item_batch/widget/item_pick_batch.dart';
import 'package:msi_app/screens/pick_item_receive/pick_item_receive_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickItemBatchScreen extends StatelessWidget {
  static const routeName = '/pick_item_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider = Provider.of<PickBatchProvider>(context, listen: false);
    await provider.getPlBatchByItemWhs(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final pickItemReceiveProvider =
        Provider.of<PickItemReceiveProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<PickBatchProvider>(context, listen: false);
    Map map = ModalRoute.of(context).settings.arguments;
    PickItemReceive pickItem = map['pickItemReceive'];
    PickListBin itemBin = map['pickListBin'];
    // PickBatch itemBatch = map['batchList'];
    // final remains = pickBatchProvider.totalPicked ;
    // final remains = pickItem.openQty - pickBatchProvider.totalPicked ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              if (pickBatchProvider.totalPicked > pickItem.quantity) {
                showAlertGreaterThanZero(
                    context,
                    pickItem.quantity == 0.0
                        ? pickItem.quantity.toStringAsFixed(authProvider.decLen)
                        : formatter.format(pickItem.quantity));
              } else {
                // update bin location
                pickItem.itemStorageLocation = itemBin.binLocation;

                // add batch list
                final batchList = pickBatchProvider.pickedItems;

                batchList.forEach((detail) {
                  // calculate bin
                  detail.bin = pickItem.itemStorageLocation;
                });
                // batchList. = itemBin.binLocation;
                pickItemReceiveProvider.addBatchList(pickItem, batchList);
                Navigator.of(context).popUntil(
                    ModalRoute.withName(PickItemReceiveScreen.routeName));
              }

              // var guider =
              //     double.tryParse(pickItem.quantity.toStringAsFixed(authProvider.decLen)) >
              //             double.tryParse(itemBin.avlQty.toStringAsFixed(authProvider.decLen))
              //         ? double.tryParse(itemBin.avlQty.toStringAsFixed(authProvider.decLen))
              //         : double.tryParse(pickItem.quantity.toStringAsFixed(authProvider.decLen));

              // pickBatchProvider.totalPicked.toStringAsFixed(authProvider.decLen) == '0.0000'
              //     ? showAlertOnZero(context)
              //     : double.tryParse(pickBatchProvider.totalPicked
              //                 .toStringAsFixed(authProvider.decLen)) >
              //             guider
              //         ? showAlertGreaterThanZero(
              //             context, guider.toStringAsFixed(authProvider.decLen))

              // : Navigator.of(context).popUntil(
              //     ModalRoute.withName(PickItemReceiveScreen.routeName));
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
                Consumer<PickBatchProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Picked',
                      provider.totalPicked == 0.0
                          ? provider.totalPicked.toStringAsFixed(authProvider.decLen)
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
            BaseTitle(pickItem.itemStorageLocation),
            BaseTextLine(
                'Total to Pick Qty',
                pickItem.quantity == 0.0
                    ? pickItem.quantity.toStringAsFixed(authProvider.decLen)
                    : formatter.format(pickItem.quantity)),
            BaseTextLine('UoM', pickItem.unitMsr),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            // BaseTextLine('Remaining', pickItem.quantity .toString()),
            // SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Batch of Item'),
                ),
                Text('Show All Batches'),
                Consumer<PickBatchProvider>(
                  builder: (_, provider, child) {
                    return Switch(
                      value: provider.showAllItem,
                      onChanged: (value) {
                        provider.toggleStatus();
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(),
            buildItemList(context, pickItem, itemBin),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(
    BuildContext context,
    PickItemReceive pickItem,
    PickListBin itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode, itemBin.binLocation),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<PickBatchProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemPickBatch(provider.items[index], pickItem),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<PickBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        final date = new DateTime.now();

        if (item.expiredDate.isAfter(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogPickBatch(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogExpired(item),
          );
          print('expired ' + item.expiredDate.toString());
          print(date);
        }
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
