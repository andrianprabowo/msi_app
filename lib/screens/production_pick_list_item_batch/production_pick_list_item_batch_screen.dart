import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_pick_list_bin_model.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/production_pick_list_item_batch_provider.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/screens/production_pick_list_item/production_pick_list_item_screen.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/widget/production_pick_list_item_batch_dialog.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/widget/production_pick_list_item_batch_list.dart';
import 'package:msi_app/screens/production_pick_list_item_batch/widget/production_pick_list_item_expired_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionPickListItemBatch extends StatelessWidget {
  static const routeName = '/production_pick_list_item_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String binCode,
  ) async {
    final provider = Provider.of<ProductionPickListItemBatchProvider>(context,
        listen: false);
    await provider.getPlBatchByItemWhs(itemCode, binCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickItemProvider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
    final productionPickListItemBatchProvider =
        Provider.of<ProductionPickListItemBatchProvider>(context,
            listen: false);
    Map map = ModalRoute.of(context).settings.arguments;
    ProductionPickListItemModel pickItem = map['productionPickListItemModel'];
    ProductionPickListBinModel itemBin = map['pickListBin'];

    final formatter = NumberFormat('#,###.0000#', 'en_US');

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick List'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              if (productionPickListItemBatchProvider.totalPicked >
                  pickItem.quantity) {
                showAlertGreaterThanZero(
                    context, formatter.format(pickItem.quantity));
              } else {
                // update bin location
                pickItem.itemStorageLocation = itemBin.binLocation;
                // add batch list
                final batchList =
                    productionPickListItemBatchProvider.pickedItems;
                //pickItemProvider.addBatchList(pickItem, batchList);
                batchList.forEach((detail) {
                  // calculate bin
                  detail.bin = pickItem.itemStorageLocation;
                });
                // batchList. = itemBin.binLocation;
                // pickItemProvider.addBatchList(pickItem, batchList);
                pickItemProvider.addBatchList(pickItem, batchList);
                Navigator.of(context).popUntil(
                    ModalRoute.withName(ProductionPickListItem.routeName));
              }

              // var guider =
              //     double.tryParse(pickItem.openQty.toStringAsFixed(4)) >
              //             double.tryParse(itemBin.avlQty.toStringAsFixed(4))
              //         ? double.tryParse(itemBin.avlQty.toStringAsFixed(4))
              //         : double.tryParse(pickItem.openQty.toStringAsFixed(4));
              // if (productionPickListItemBatchProvider.totalPicked
              //         .toStringAsFixed(4) ==
              //     '0.0000') {
              //   showAlertOnZero(context);
              // } else {
              //   if (double.tryParse(productionPickListItemBatchProvider
              //           .totalPicked
              //           .toStringAsFixed(4)) >
              //       guider) {
              //     showAlertGreaterThanZero(context, guider.toStringAsFixed(4));
              //   } else {
              //     pickItemProvider.addBatchList(pickItem, batchList);
              //     Navigator.of(context).popUntil(
              //         ModalRoute.withName(ProductionPickListItem.routeName));
              //   }
              // }

              /* productionPickListItemBatchProvider.totalPicked
                          .toStringAsFixed(2) ==
                      '0.00'
                  ? showAlertOnZero(context)
                  : double.tryParse(productionPickListItemBatchProvider
                              .totalPicked
                              .toStringAsFixed(2)) >
                          guider
                      ? showAlertGreaterThanZero(context, guider.toString())
                      : Navigator.of(context).popUntil(ModalRoute.withName(
                          ProductionPickListItem.routeName)); */
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
                Consumer<ProductionPickListItemBatchProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Picked',
                      provider.totalPicked == 0.0
                          ? provider.totalPicked.toStringAsFixed(4)
                          : formatter.format(provider.totalPicked),
                    ),
                  );
                }),
                SizedBox(width: getProportionateScreenWidth(kLarge)),
                FlatButton.icon(
                    onPressed: () {
                      productionPickListItemBatchProvider.clear();
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    label: Text('CLEAR'))
              ],
            ),
            BaseTitle(pickItem.itemCode),
            BaseTitle(pickItem.description + ' / ' + pickItem.unitMsr),
            BaseTitle(pickItem.itemStorageLocation),
            // BaseTitle(pickItem.openQty == 0.0
            //     ? 'Total to Pick ' + pickItem.quantity.toStringAsFixed(4)
            //     : 'Total to Pick ' + formatter.format(pickItem.openQty)),
            BaseTextLine(
                'Total to Pick',
                pickItem.quantity == 0.0
                    ? pickItem.quantity.toStringAsFixed(4)
                    : formatter.format(pickItem.quantity)),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('UoM', pickItem.unitMsr),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTitle(itemBin.avlQty == 0.0
                ? 'Avl Qty Bin Loc : ' + itemBin.avlQty.toStringAsFixed(4)
                : 'Avl Qty Bin Loc : ' + formatter.format(itemBin.avlQty)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            // BaseTitle('List Batch of Item'),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Batch of Item'),
                ),
                Text('Show All Batches'),
                Consumer<ProductionPickListItemBatchProvider>(
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

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ProductionPickListItemBatchProvider>(context,
        listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
          final date = new DateTime.now();

        if (item.expiredDate.isAfter(date)) {
          showModalBottomSheet(
            context: context,
            builder: (_) => ProductionPickListItemBatchDialog(item),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (_) => ProductionPickListItemExpired(item),
          );
        }
      },
    );
  }

  Widget buildItemList(
    BuildContext context,
    ProductionPickListItemModel pickItem,
    ProductionPickListBinModel itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode, itemBin.binLocation),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ProductionPickListItemBatchProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ProductionPickListItemBatchList(
                            provider.items[index], pickItem),
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
    final productionPickListItemBatchProvider =
        Provider.of<ProductionPickListItemBatchProvider>(context,
            listen: false);
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
                    productionPickListItemBatchProvider.clear();
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
