import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_item_provider.dart';
import 'package:msi_app/providers/production_receipt_provider.dart';
import 'package:msi_app/screens/production_receipt_final_check/production_receipt_final_check_screen.dart';
import 'package:msi_app/screens/production_receipt_item/widgets/production_receipt_item_list.dart';
import 'package:msi_app/screens/production_receipt_item/widgets/production_receipt_item_qty_dialog.dart';
import 'package:msi_app/screens/production_receipt_item/widgets/production_receipt_item_qty_non_batch_dialog.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/item_bin_production_receipt.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceiptItem extends StatelessWidget {
  static const routeName = '/production_receipt_item';

  Future<void> fetchData(BuildContext context, String docNum) async {
    final itemPoProvider =
        Provider.of<ProductionReceiptItemProvider>(context, listen: false);
    await itemPoProvider.getPoDetailByDocNum(docNum);

    final poProvider =
        Provider.of<ProductionReceiptProvider>(context, listen: false);
    poProvider.selected.detailList = itemPoProvider.items;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.clearBin();
  }

  void createProductionReceipt(BuildContext context) {
    Provider.of<ProductionReceiptProvider>(context, listen: false)
        .createProductionReceipt();
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<ProductionReceiptProvider>(context, listen: false);
    final po = poProvider.selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    /* final provider =
        Provider.of<ProductionReceiptItemProvider>(context, listen: false);
    var status = 0;
    var msg = []; */
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Receipt Finish Goods'),
        actions: [
          IconButton(
              icon: Icon(Icons.post_add),
              onPressed: () {
                if (authProvider.binId == "Please Select Bin") {
                  final snackBar = SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: getProportionateScreenWidth(kLarge)),
                        Text('Please Select Bin First'),
                      ],
                    ),
                  );
                  globalKey.currentState.showSnackBar(snackBar);
                  return;
                }

                Navigator.of(context)
                      .pushNamed(ProductionReceiptFinalCheck.routeName);
                /* if (authProvider.binId == "Please Select Bin") {
                  msg.add("Bin is Required");
                }
                for (var i = 0; i < provider.items.length; i++) {
                  if (provider.items[i].quantity.toStringAsFixed(2) != '0.00') {
                    status = 1;
                  } else {
                    msg.add("Please Select at Least 1 Item");
                  }
                }
                if (status == 1 && authProvider.binId != "Please Select Bin") {
                  Navigator.of(context)
                      .pushNamed(ProductionReceiptFinalCheck.routeName);
                } else {
                  showAlert(context, msg);
                } */
              })
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
            BaseTextLine('Production Number', po.poNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Document Date', convertDate(po.docDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            ItemBinProductionReceipt(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, po),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<ProductionReceiptItemProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value.toUpperCase());
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? ProductionReceiptItemQtyDialog(item)
              : ProductionReceiptItemQtyNonBatchDialog(item),
        );
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionReceiptModel po) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, po.poNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ProductionReceiptItemProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ProductionReceiptItemList(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  /* Future<void> showAlert(BuildContext context, List message) async {
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
              Text(message.join(', ')),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text('OK'),
                  onPressed: () {
                    message.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  } */
}
