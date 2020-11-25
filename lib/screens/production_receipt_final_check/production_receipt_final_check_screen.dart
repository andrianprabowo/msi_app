import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_provider.dart';
import 'package:msi_app/screens/production_receipt/production_receipt_screen.dart';
import 'package:msi_app/screens/production_receipt_final_check/widgets/production_receipt_item_list_final.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ProductionReceiptFinalCheck extends StatelessWidget {
  static const routeName = '/production_receipt_final_check';

  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Receipt Finish Goods'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              final poProvider = Provider.of<ProductionReceiptProvider>(context,
                  listen: false);
              try {
                final response = await poProvider.createProductionReceipt();
                final docId = response['id'];
                Navigator.of(context).pop();
                await showSuccessDialog(context, docId);
              } catch (error) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: getProportionateScreenWidth(kLarge)),
                        Text(error.toString()),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> showSuccessDialog(BuildContext context, int docId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, color: Colors.green, size: 50),
              Divider(),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Success create Receipt Finish Goods'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text(
                docId.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        ProductionReceipt.routeName, (route) => false);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<ProductionReceiptProvider>(context, listen: false);
    final binSelected = Provider.of<AuthProvider>(context, listen: false);
    final po = poProvider.selected;

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Receipt Finish Goods'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (poProvider.detailList.isEmpty) {
                final snackBar = SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: getProportionateScreenWidth(kLarge)),
                      Text('Please Select One or More Item First'),
                    ],
                  ),
                );
                globalKey.currentState.showSnackBar(snackBar);
                return;
              } else {
                postData(context);
              }
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
            BaseTextLine('PO Number', po.poNumber),
            BaseTextLine('Delivery Date', convertDate(po.docDate)),
            BaseTextLine('Memo', po.vendorName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Whs Code', po.vendorCode),
            BaseTextLine('Whs Name', binSelected.warehouseName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Bin', binSelected.binId ?? 'Empty'),
            // BaseTextLine('Staging Bin Name', po.storageLocationName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Details'),
            Divider(),
            buildItemDetails(poProvider.detailList),
          ],
        ),
      ),
    );
  }

  Widget buildItemDetails(List<ProductionReceiptItemModel> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return ProductionReceiptItemListFinal(list[i]);
        },
      ),
    );
  }
}
