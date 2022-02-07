import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_number_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_change_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/screens/production_issue_final_check/production_issue_final_check_screen.dart';
import 'package:msi_app/screens/production_issue_item_change/widgets/production_issue_item_change_dialog.dart';
import 'package:msi_app/screens/production_issue_item_change/widgets/production_issue_item_list_change.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionIssueItemChange extends StatelessWidget {
  static const routeName = '/production_issue_item_change';

  Future<void> fetchData(
    BuildContext context,
    String pickNumber,
  ) async {
    final itemBinProvider =
        Provider.of<ProductionIssueItemChangeProvider>(context, listen: false);
    await itemBinProvider.getItemChange(context, pickNumber);
    print('kenapa ' + pickNumber);
    // final newA = itemBinProvider.selected.itemCode;

    // final stagingBinProvider =
    //     Provider.of<ProductionIssueItemProvider>(context, listen: false);
    // stagingBinProvider.selected.itemCode = ;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final transactionNumberSelected =
        Provider.of<ProductionIssueNumberProvider>(context, listen: false)
            .selected;
    final itemChange =
        Provider.of<ProductionIssueItemProvider>(context, listen: false)
            .selected;

    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Issue (Raw Material)'),
        actions: [
          IconButton(
              icon: Icon(Icons.post_add),
              onPressed: () {
                if (transactionNumberSelected.totalItem != 0) {
                  print("disini error");
                  print(transactionNumberSelected.totalQty);

                  final snackBar = SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: getProportionateScreenWidth(kLarge)),
                        Text('Please Input ' +
                            transactionNumberSelected.totalItem.toString() +
                            ' More items'),
                      ],
                    ),
                  );
                  globalKey.currentState.showSnackBar(snackBar);
                  return;
                }

                Navigator.of(context)
                    .pushNamed(ProductionIssueFinalCheck.routeName);
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
            BaseTitleColor('This item will be change'),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle(itemChange.itemCode),
            BaseTitle(itemChange.itemName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items Change'),
            Divider(),
            buildItemList(context, transactionNumberSelected),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<ProductionIssueItemChangeProvider>(context, listen: false);
    final listProvider =
        Provider.of<ProductionIssueItemChangeProvider>(context, listen: false);

    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);

        listProvider.selectPo(item);
        showModalBottomSheet(
            context: context,
            builder: (_) => ProductionIssueItemChangeDialog(item));
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionIssueNumberModel item) {
    print('sdasdsa' + item.pickNumber);
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, item.pickNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          print('test'+ snapshot.hasError.toString());
          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ProductionIssueItemChangeProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ProductionIssueItemListChange(
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
              Text('Please Select at Least 1 Item'),
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
