import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_batch_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/providers/production_issue_provider.dart';
import 'package:msi_app/screens/production_issue_item/production_issue_item_screen.dart';
import 'package:msi_app/screens/production_issue_item_batch/widgets/dialog_expired.dart';
import 'package:msi_app/screens/production_issue_item_batch/widgets/production_issue_item_batch_list.dart';
import 'package:msi_app/screens/production_issue_item_batch/widgets/production_issue_item_batch_list_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemBatch extends StatelessWidget {
  static const routeName = '/production_issue_item_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider =
        Provider.of<ProductionIssueItemBatchProvider>(context, listen: false);
    await provider.getBatchListByItemWarehouse(itemCode, binCode);
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final itemBatchProvider =
        Provider.of<ProductionIssueItemBatchProvider>(context, listen: false);
    ProductionIssueItemModel item = ModalRoute.of(context).settings.arguments;
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    // var avlQty = item.availableQty == 0.0
    //     ? item.availableQty.toStringAsFixed(4)
    //     : formatter.format(item.availableQty);
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Issue (Raw Material)'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              final itemProvider = Provider.of<ProductionIssueItemProvider>(
                  context,
                  listen: false);
              final itemNumberProvider =
                  Provider.of<ProductionIssueNumberProvider>(context,
                      listen: false);
              final itemBatchProvider =
                  Provider.of<ProductionIssueItemBatchProvider>(context,
                      listen: false);
              final batchList = itemBatchProvider.pickedItems;
              /* if (item.fgBatch == "Y") {
                itemProvider.addBatchList(item, batchList);
              } */
              if (itemBatchProvider.totalPicked.toStringAsFixed(authProvider.decLen) ==
                  '0.0000') {
                showAlertOnZero(context);
              }
              // disini
              print("disini ${itemBatchProvider.totalPicked}");
              print("disini2 ${item.availableQty}");
              // if (itemBatchProvider.totalPicked != item.availableQty) {
              //   print("disini masuk");

              //   final snackBar = SnackBar(
              //     content: Row(
              //       children: [
              //         Icon(Icons.error_outline, color: Colors.red),
              //         SizedBox(width: getProportionateScreenWidth(kLarge)),
              //         Text('Total Put Qty Must Be Same Than Planned Qty'),
              //       ],
              //     ),
              //   );
              //   globalKey.currentState.showSnackBar(snackBar);
              //   return;
              // }

              
              //  else {
              //   if (double.tryParse(
              //           itemBatchProvider.totalPicked.toStringAsFixed(4)) >
              //       double.tryParse(item.availableQty.toStringAsFixed(4))) {
              //     showAlertGreaterThanZero(context, avlQty);
              //   } else {
              if (item.fgBatch == "Y") {
                // final batchLists = itemNumberProvider.items;
                //               batchLists.forEach((detail) {
                //                 // calculate bin
                //                 // detail.totalRemain = batchList.first.putQty;
                //                 detail.totalRemain = batchList.first.putQty;
                //               });
                //
                //
                print("xx1    ${itemNumberProvider.selected.totalQty}");

                // itemNumberProvider.items.first.totalQty =
                //     itemNumberProvider.items.first.totalQty -
                //         itemBatchProvider.totalPicked;
                itemNumberProvider.selected.totalQty =
                    itemNumberProvider.selected.totalQty -
                        itemBatchProvider.totalPicked;
                itemNumberProvider.selected.totalItem =
                    itemNumberProvider.selected.totalItem -
                        1;
                print("xx    ${itemNumberProvider.selected.totalItem}");

                itemProvider.addBatchList(item, batchList);

                //

                // itemNumberProvider.items.sel.totalRemain =
                //   batchList.first.putQty;
              }
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(ProductionIssueItem.routeName));

              //   }
              // }
              /* itemBatchProvider.totalPicked.toStringAsFixed(2) == '0.00'
                  ? showAlertOnZero(context)
                  : double.tryParse(itemBatchProvider.totalPicked
                              .toStringAsFixed(2)) >
                          double.tryParse(item.availableQty.toStringAsFixed(2))
                      ? showAlertGreaterThanZero(
                          context, item.availableQty.toStringAsFixed(2))
                      : Navigator.of(context).popUntil(
                          ModalRoute.withName(ProductionIssueItem.routeName)); */
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
                Consumer<ProductionIssueItemBatchProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Put Qty',
                      provider.totalPicked == 0.0
                          ? provider.totalPicked.toStringAsFixed(authProvider.decLen)
                          : formatter.format(provider.totalPicked),
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
            BaseTitle(item.itemName + ' / ' + item.unitMsr),
            BaseTitle(item.availableQty == 0.0
                ? 'Planned qty : ' + item.availableQty.toStringAsFixed(authProvider.decLen)
                : 'Planned qty : ' + formatter.format(item.availableQty)),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<ProductionIssueItemBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or Scan Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        final date = new DateTime.now();

        if (item.expiredDate.isBefore(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => DialogExpired(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => ProductionIssueItemBatchListDialog(item),
          );
          print('expired ' + item.expiredDate.toString());
          print(date);
        }
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionIssueItemModel item) {
    final provider =
        Provider.of<ProductionIssueProvider>(context, listen: false);
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, item.itemCode, provider.selected.binCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ProductionIssueItemBatchProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child:
                            ProductionIssueItemBatchList(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
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
    final itemBatchProvider =
        Provider.of<ProductionIssueItemBatchProvider>(context, listen: false);
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
                    itemBatchProvider.clear();
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
