import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_item_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_pick_list_provider.dart';
import 'package:msi_app/screens/production_pick_list/production_pick_list_screen.dart';
import 'package:msi_app/screens/production_pick_list_final_check/widget/production_pick_list_final_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/item_bin_production_picklist.dart';
import 'package:msi_app/widgets/item_date_prod_picklist.dart';
import 'package:provider/provider.dart';

class ProductionPickListFinalCheck extends StatelessWidget {
  static const routeName = '/production_pick_list_final_check';

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ProductionPickListProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final item = provider.selected;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Pick List'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
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

              if (provider.detailList.isEmpty) {
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
            ItemDateProdPickList(),
            BaseTextLine('Pick Number', item.pickNumber),
            BaseTextLine('Pick Date', convertDate(item.pickDate)),
            BaseTextLine('Remark', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Trf to Whs Code', item.cardCode),
            BaseTextLine('Trf to Whs Name', item.cardName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            ItemBinProductionPickList(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Details'),
            Divider(),
            buildItemDetails(provider.detailList)
          ],
        ),
      ),
    );
  }

  Widget buildItemDetails(List<ProductionPickListItemModel> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return ProductionPickListFinalDetail(list[i]);
        },
      ),
    );
  }

  int a = 1;
  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Pick List'),
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
                final provider = Provider.of<ProductionPickListProvider>(
                    context,
                    listen: false);
                try {
                  final response = await provider.createProductionPickList();
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
              Text('Success create Pick List'),
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
                        ProductionPickList.routeName, (route) => false);
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
