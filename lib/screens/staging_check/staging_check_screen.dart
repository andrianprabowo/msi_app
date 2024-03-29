import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/providers/staging_bin.provider.dart';
import 'package:msi_app/screens/put_away/put_away_screen.dart';
import 'package:msi_app/screens/staging_check/widgets/staging_detail_check.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/item_date_putaway.dart';
import 'package:provider/provider.dart';

class StagingCheckScreen extends StatelessWidget {
  static const routeName = '/staging_check';
  int a = 1;
  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Put Away From Vendor'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              if (a == 1) {
                a = 2;
                print("object");
                final provider =
                    Provider.of<StagingBinProvider>(context, listen: false);
                try {
                  final response = await provider.createPutAway();
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
              } else {
                print("xxx");
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
              Text('Success create Put Away'),
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
                        PutAwayScreen.routeName, (route) => false);
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
    final provider = Provider.of<StagingBinProvider>(context, listen: false);
    final item = provider.selected;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Put Away'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (provider.itemBinList.isEmpty) {
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
            ItemDatePutAway(),
            BaseTextLine('Staging Bin Location', item.binCode),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Details'),
            Divider(),
            buildItemDetails(provider.itemBinList),
          ],
        ),
      ),
    );
  }

  Widget buildItemDetails(List<ItemBin> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return StagingDetailCheck(list[i]);
        },
      ),
    );
  }
}
