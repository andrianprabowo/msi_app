import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_number_list_model.dart';
import 'package:msi_app/providers/production_receipt_rm_bin.dart';
import 'package:msi_app/providers/production_receipt_rm_item_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_bin/production_receipt_rm_bin_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_final_check/production_receipt_rm_final_check_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_item/widgets/production_receipt_rm_item_list.dart';
import 'package:msi_app/screens/production_receipt_rm_item_batch/production_receipt_rm_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMItem extends StatelessWidget {
  static const routeName = '/production_receipt_rm_item';

  Future<void> refreshData(
      BuildContext context, String docNumber, String cardCode) async {
    final inventoryItemProvider =
        Provider.of<ProductionReceiptRMItemListProvider>(context,
            listen: false);
    await inventoryItemProvider.getInventItemByPlNo(docNumber);

    final pickItemProvider =
        Provider.of<ProductionReceiptRMBinProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(cardCode);

    final inventoryDispatchDetailProvider =
        Provider.of<ProductionReceiptRMNumberListProvider>(context,
            listen: false);
    inventoryDispatchDetailProvider.selected.itemList =
        inventoryItemProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ProductionReceiptRMNumberListProvider>(context,
            listen: false)
        .selected;
    /* final provider = Provider.of<ProductionReceiptRMItemListProvider>(context,
        listen: false);
    var status = 0; */
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ProductionReceiptRMFinalCheck.routeName);
              /* for (var i = 0; i < provider.items.length; i++) {
                if (provider.items[i].pickedQty.toStringAsFixed(2) != '0.00') 
                  status = 1;
              }
              if(status == 1) {
                Navigator.of(context).pushNamed(ProductionReceiptRMFinalCheck.routeName);
              } else {
                showAlertOnZero(context);
              } */
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
            BaseTextLine('Pick Number', item.docNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Pick Date', convertDate(item.docDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Remarks', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ProductionReceiptRMItemListProvider>(context,
        listen: false);
    return InputScan(
      label: 'Item Code',
      hint: 'Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value.toUpperCase());
        item.fgBatch == "Y"
            ? Navigator.of(context).pushNamed(
                ProductionReceiptRMItemBatch.routeName,
                arguments: item)
            : Navigator.of(context).pushNamed(
                ProductionReceiptRmBinScreen.routeName,
                arguments: item);
        // showModalBottomSheet(
        //     context: context,
        //     builder: (_) => ProductionReceiptRMItemNonBatchDialog(item));
      },
    );
  }

  Widget buildItemList(
      BuildContext context, ProductionReceiptRMNumberListModel item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.docNumber, item.cardCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () =>
                refreshData(context, item.docNumber, item.cardCode),
            child: Consumer<ProductionReceiptRMItemListProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProductionReceiptRMItemList(
                              provider.items[index]),
                        );
                      },
                    ),
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
              Text("Please Select at Least 1 item"),
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
