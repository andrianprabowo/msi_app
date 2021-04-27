import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_batch_list_provider.dart';
// import 'package:msi_app/providers/production_receipt_rm_item_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_bin/production_receipt_rm_bin_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_item_batch/widgets/production_receipt_rm_item_batch_list.dart';
import 'package:msi_app/screens/production_receipt_rm_item_batch/widgets/production_receipt_rm_item_batch_list_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMItemBatch extends StatelessWidget {
  static const routeName = '/production_receipt_rm_item_batch';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
  ) async {
    final provider = Provider.of<ProductionReceiptRMItemListBatchListProvider>(
        context,
        listen: false);
    final providerBinHeader =
        Provider.of<ProductionReceiptRMProvider>(context, listen: false);
    final providerDetail = Provider.of<ProductionReceiptRMNumberListProvider>(
        context,
        listen: false);
    final binHeader = providerBinHeader.selected;
    final details = providerDetail.selected;
    await provider.getPlBatchByItemWhs(
        itemCode, binHeader.binCode, details.docNumber);
  }

  @override
  Widget build(BuildContext context) {
    /* final provider =
        Provider.of<ProductionReceiptRMProvider>(context, listen: false); */
    // final pickItemProvider = Provider.of<ProductionReceiptRMItemListProvider>(
    //     context,
    //     listen: false);
    final pickBatchProvider =
        Provider.of<ProductionReceiptRMItemListBatchListProvider>(context,
            listen: false);
    ProductionReceiptRMItemListModel pickItem =
        ModalRoute.of(context).settings.arguments;
    final formatter = NumberFormat('#,###.0000#', 'en_US');
    var openQty = pickItem.openQty == 0.0
        ? pickItem.openQty.toStringAsFixed(4)
        : formatter.format(pickItem.openQty);
        var totalPic = pickItem.quantity == 0.0
        ? pickItem.quantity.toStringAsFixed(4)
        : formatter.format(pickItem.quantity);
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              // add batch list
              // final batchList = pickBatchProvider.pickedItems;
              // pickItemProvider.addBatchList(pickItem, batchList);
              pickBatchProvider.totalPicked.toStringAsFixed(4) == '0.0000'
                  ? showAlertOnZero(context)
                  : double.tryParse(pickBatchProvider.totalPicked
                              .toStringAsFixed(4)) >
                          double.tryParse(pickItem.openQty.toStringAsFixed(4))
                      ? showAlertGreaterThanZero(context, openQty)
                      :
                      // Navigator.of(context).popUntil(ModalRoute.withName(
                      //     ProductionReceiptRMItem.routeName));
                      Navigator.of(context).pushNamed(
                          ProductionReceiptRmBinScreen.routeName,
                          arguments: pickItem);
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
                Consumer<ProductionReceiptRMItemListBatchListProvider>(
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
                      pickBatchProvider.clear();
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    label: Text('CLEAR'))
              ],
            ),
            BaseTitle(pickItem.itemCode),
            BaseTitle(pickItem.description + ' / ' + pickItem.unitMsr),
            BaseTextLine('Total to Pick',totalPic) ,
            BaseTextLine('UoM', pickItem.unitMsr),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, pickItem),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ProductionReceiptRMItemListBatchListProvider>(
        context,
        listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Item Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => ProductionReceiptRMItemBatchDialog(item),
        );
      },
    );
  }

  Widget buildItemList(
    BuildContext context,
    ProductionReceiptRMItemListModel pickItem,
    //InventoryDispatchBin itemBin,
  ) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, pickItem.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ProductionReceiptRMItemListBatchListProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ProductionReceiptRMItemBatchList(
                            provider.items[index]),
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
    final pickBatchProvider =
        Provider.of<ProductionReceiptRMItemListBatchListProvider>(context,
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
                    pickBatchProvider.clear();
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
