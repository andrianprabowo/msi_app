import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_item.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_bin_provider.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/stock_counting_bin/stock_counting_bin_screen.dart';
import 'package:msi_app/screens/stock_counting_check/widget/stock_counting_detail_check.dart';
import 'package:msi_app/screens/stock_counting_header/stock_counting_header_screen.dart';
import 'package:msi_app/screens/stock_counting_item/stock_counting_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:provider/provider.dart';

class StockCountingCheckScreen extends StatelessWidget {
  static const routeName = '/stock_counting_check';

  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Stock Counting'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              final provider = Provider.of<StockCountingHeaderProvider>(context,
                  listen: false);
              try {
                final response = await provider.createReceiptVendor();
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
              Text('Success create '),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Stock Counting'),
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
                        StockCountingHeaderScreen.routeName, (route) => false);
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
    final provider =
        Provider.of<StockCountingHeaderProvider>(context, listen: false);
    final item = provider.selected;

    // final itemProvider =
    //     Provider.of<StockCountingItemProvider>(context, listen: false);
    // final itemPro = itemProvider.selected;

    final providerItem =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    // final itemSelected = provider.selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Stock Counting Check'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (providerItem.itemShow.isEmpty) {
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
            BaseTextLine('Inventory Count No', item.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Counting Date', convertDate(item.pickDate)),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Remark', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Counter Assign', authProvider.username),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Warehouse Name', authProvider.warehouseName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('Add More Item From :'),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kTiny)),
            Row(
              children: [
                FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          StockCountingItemScreen.routeName,
                          arguments: item);
                      // Navigator.of(context).popUntil(ModalRoute.withName(
                      //     StockCountingItemScreen.routeName));
                    },
                    icon: Icon(Icons.playlist_add),
                    color: Colors.blueAccent,
                    label: Text('Same Bin')),
                SizedBox(width: getProportionateScreenWidth(kLarge)),
                FlatButton.icon(
                    onPressed: () {
                      // final pickItemReceiveProvider =
                      //     Provider.of<StockCountingItemProvider>(context,
                      //         listen: false);
                      // pickItemReceiveProvider.inputQty(
                      //   itemPro,
                      //   double.parse(itemPro.quantity.toString()),
                      // );

                      Navigator.of(context).popUntil(ModalRoute.withName(
                          StockCountingBinScreen.routeName));
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushNamed(
                      //     StockCountingBinScreen.routeName,
                      //     arguments: item);
                    },
                    icon: Icon(Icons.add_circle_outline),
                    color: Colors.blueAccent,
                    label: Text('Another Bin'))
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Details'),
            Divider(),
            buildItemDetails(providerItem.itemShow),
          ],
        ),
      ),
    );
  }

  Widget buildItemDetails(List<StockCountingItem> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return StockCountingDetailCheck(list[i]);
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<StockCountingBinProvider>(context, listen: false);
    return InputScan(
      label: 'Stock Counting Bin',
      hint: 'Input or scan Stock Counting Bin',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
        provider.selectStagingBin(item);
        Navigator.of(context).pushNamed(StockCountingItemScreen.routeName);
      },
    );
  }
}
