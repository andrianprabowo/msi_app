import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_item_so.dart';
import 'package:msi_app/providers/inventory_dispatch_detail_so_provider.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/inventory_dispatch_check_so/widget/inventory_dispatch_detail_check_so.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:provider/provider.dart';

class InventoryDispatchCheckSoScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_check_so';

  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Inventory Dispatch SO'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              final provider = Provider.of<InventoryDispatchDetailSoProvider>(
                  context,
                  listen: false);
              try {
                final response =
                    await provider.createInventoryDispatch(context);
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
              Text('Success create Inventory Dispatch'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Sales Order'),
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
    final provider =
        Provider.of<InventoryDispatchDetailSoProvider>(context, listen: false);
    final item = provider.selected;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch Sales Order'),
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
            BaseTextLine('Doc Number', item.docNumber),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            BaseTextLine('Remark', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Vendor Code', item.cardCode),
            BaseTextLine('Vendor Name', item.cardName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            // buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Details'),
            Divider(),
            buildItemDetails(provider.detailList),
          ],
        ),
      ),
    );
  }

  Widget buildItemDetails(List<InventoryDispatchItemSo> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return InventoryDispatchDetailCheckSo(list[i]);
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<InventoryDispatchDetailSoProvider>(context, listen: false);
    return InputScan(
      label: 'Storage Location',
      hint: 'Input or scan Storage Location',
      scanResult: (value) {
        provider.selected.storageLocation = value;
        // final item = provider.findByPoNumber(value);
        // provider.selectPo(item);
        // Navigator.of(context).pushNamed(ReceiptDetailScreen.routeName);
      },
    );
  }
}
