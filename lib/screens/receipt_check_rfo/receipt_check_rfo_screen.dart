import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/purchase_order_rfo_provider.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/receipt_check_rfo/widget/item_detail_check_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/prefs.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class ReceiptCheckRfoScreen extends StatelessWidget {
  static const routeName = '/receipt_check_rfo';

  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Receipt Return from Outlet'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              final poProvider =
                  Provider.of<PurchaseOrderRfoProvider>(context, listen: false);
              try {
                final response = await poProvider.createReceiptVendor();
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
    final binId = await Prefs.getString(Prefs.binId);
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
              Text('Success create Receipt'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Return from Outlet'),
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
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<PurchaseOrderRfoProvider>(context, listen: false);
    final po = poProvider.selected;
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt From Vendor Check'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              postData(context);
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
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Vendor Code', po.vendorCode),
            BaseTextLine('Vendor Name', po.vendorName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Bin', authProvider.binId ?? 'Empty'),
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

  Widget buildItemDetails(List<ItemPurchaseOrderRfo> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return ItemDetailCheckRfo(list[i]);
        },
      ),
    );
  }
}
