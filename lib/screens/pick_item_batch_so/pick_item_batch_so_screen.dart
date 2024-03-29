import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/pick_item_receive_so.dart';
import 'package:msi_app/models/pick_list_bin_so.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_batch_so_provider.dart';
import 'package:msi_app/providers/pick_item_receive_so_provider.dart';
import 'package:msi_app/screens/pick_item_batch_so/widget/dialog_pick_batch_so.dart';
import 'package:msi_app/screens/pick_item_batch_so/widget/item_pick_batch_so.dart';
import 'package:msi_app/screens/pick_item_receive_so/pick_item_receive_so_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class PickItemBatchSoScreen extends StatelessWidget {
  static const routeName = '/pick_item_batch_So';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider = Provider.of<PickBatchSoProvider>(context, listen: false);
    await provider.getPlBatchByItemWhs(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
 final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final pickItemProvider =
        Provider.of<PickItemReceiveSoProvider>(context, listen: false);
    final pickBatchProvider =
        Provider.of<PickBatchSoProvider>(context, listen: false);
    Map map = ModalRoute.of(context).settings.arguments;
    PickItemReceiveSo pickItem = map['pickItemReceive'];
    PickListBinSo itemBin = map['pickListBin'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Picker Pick List Sales Order'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              if (pickBatchProvider.totalPicked > pickItem.quantity) {
                showAlertGreaterThanZero(
                    context, formatter.format(pickItem.quantity));
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
                pickItemProvider.addBatchList(pickItem, batchList);
                Navigator.of(context).popUntil(
                    ModalRoute.withName(PickItemReceiveSoScreen.routeName));
              }
              // var guider =
              //     double.tryParse(pickItem.openQty.toStringAsFixed(authProvider.decLen)) >
              //             double.tryParse(itemBin.avlQty.toStringAsFixed(authProvider.decLen))
              //         ? double.tryParse(itemBin.avlQty.toStringAsFixed(authProvider.decLen))
              //         : double.tryParse(pickItem.openQty.toStringAsFixed(authProvider.decLen));

              // pickBatchProvider.totalPicked.toStringAsFixed(authProvider.decLen) == '0.00'
              //     ? showAlertOnZero(context)
              //     : double.tryParse(pickBatchProvider.totalPicked
              //                 .toStringAsFixed(authProvider.decLen)) >
              //             guider
              //         ? showAlertGreaterThanZero(
              //             context, guider.toStringAsFixed(authProvider.decLen))
              //         : Navigator.of(context).popUntil(ModalRoute.withName(
              //             PickItemReceiveSoScreen.routeName));
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
                Consumer<PickBatchSoProvider>(
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
            BaseTextLine('SO Quantity',  
                      pickItem.quantity == 0.0
                          ? pickItem.quantity.toStringAsFixed(authProvider.decLen)
                          : formatter.format(pickItem.quantity)),
            BaseTextLine('UoM', pickItem.unitMsr),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Batch of Item'),
                ),
                Text('Show All Batches'),
                Consumer<PickBatchSoProvider>(
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
    PickItemReceiveSo pickItem,
    PickListBinSo itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode, itemBin.binLocation),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<PickBatchSoProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemPickBatchSo(provider.items[index], pickItem),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<PickBatchSoProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        // if (provider.totalShow == item.show) {
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogPickBatchSo(item),
        );
        // }
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
