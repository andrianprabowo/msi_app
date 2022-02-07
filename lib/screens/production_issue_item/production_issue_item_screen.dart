import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/production_issue_number_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_issue_item_provider.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/providers/production_issue_provider.dart';
import 'package:msi_app/screens/production_issue_final_check/production_issue_final_check_screen.dart';
import 'package:msi_app/screens/production_issue_item/widgets/production_issue_item_list.dart';
import 'package:msi_app/screens/production_issue_item/widgets/production_issue_item_non_batch_dialog.dart';
import 'package:msi_app/screens/production_issue_item_batch/production_issue_item_batch_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionIssueItem extends StatelessWidget {
  static const routeName = '/production_issue_item';

  Future<void> refreshData(BuildContext context, String pickNumber) async {
    final itemBinProvider =
        Provider.of<ProductionIssueItemProvider>(context, listen: false);
    await itemBinProvider.getItemInStagingBin(pickNumber);

    final stagingBinProvider =
        Provider.of<ProductionIssueProvider>(context, listen: false);
    stagingBinProvider.selected.itemBinList = itemBinProvider.items;
  }
  
  
  Future<void> fetchData(
    BuildContext context,
    String pickNumber,
  ) async {
   final itemBinProvider =
        Provider.of<ProductionIssueItemProvider>(context, listen: false);
    await itemBinProvider.getItemInStagingBin(pickNumber);

    final stagingBinProvider =
        Provider.of<ProductionIssueProvider>(context, listen: false);
    stagingBinProvider.selected.itemBinList = itemBinProvider.items;
  }

  @override
  Widget build(BuildContext context) {
   final authProvider = Provider.of<AuthProvider>(context, listen: false);
   
    final formatter =
        NumberFormat(('#,###.' + authProvider.decString), 'en_US');
    final transactionNumberSelected =
        Provider.of<ProductionIssueNumberProvider>(context, listen: false)
            .selected;
    // final itemsProvider =
    //     Provider.of<ProductionIssueItemProvider>(context, listen: false)
    //         .selected;
// if(itemsProvider.putQty != 0){
//    print("nul ga? ");
// }else{
//    print("ga masukkkkk");

// }
  final globalKey = GlobalKey<ScaffoldState>();
   

    final stagingBin =
        Provider.of<ProductionIssueProvider>(context, listen: false);
    /* final provider =
        Provider.of<ProductionIssueItemProvider>(context, listen: false);
    var status = 0; */
    stagingBin.selected.pickNumber = transactionNumberSelected.pickNumber;
    stagingBin.selected.pickDate = transactionNumberSelected.pickDate;
    stagingBin.selected.pickRemark = transactionNumberSelected.pickRemark;
    stagingBin.selected.plant = transactionNumberSelected.plant;
    stagingBin.selected.plantName = transactionNumberSelected.plantName;
    // stagingBin.selected.totalQty = transactionNumberSelected.totalQty;
    stagingBin.selected.totalRemain = transactionNumberSelected.totalRemain;
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
                      Text('Please Input ' + transactionNumberSelected.totalItem.toString()  +' More items'),
                    ],
                  ),
                );
                globalKey.currentState.showSnackBar(snackBar);
                return;
              }

                Navigator.of(context)
                    .pushNamed(ProductionIssueFinalCheck.routeName);
                /* for (var i = 0; i < provider.items.length; i++) {
                  if (provider.items[i].putQty.toStringAsFixed(2) != '0.00') 
                    status = 1;
                }
                if(status == 1) {
                  Navigator.of(context)
                    .pushNamed(ProductionIssueFinalCheck.routeName);
                } else {
                  showAlertOnZero(context);
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
            BaseTextLine(
                'Production Number', transactionNumberSelected.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Production Date',
                convertDate(transactionNumberSelected.pickDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Product Code', transactionNumberSelected.productCode),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Product Name', transactionNumberSelected.productName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine(
                'Planned Qty',
                transactionNumberSelected.quantity == 0.0
                    ? transactionNumberSelected.quantity.toStringAsFixed(authProvider.decLen)
                    : formatter.format(transactionNumberSelected.quantity)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Uom', transactionNumberSelected.uom),
            SizedBox(height: getProportionateScreenHeight(kLarge)),

            // BaseTextLine(
            //     'total qty', transactionNumberSelected.totalQty.toString()),
            // SizedBox(height: getProportionateScreenHeight(kLarge)),
            // // if(itemsProvider.putQty != null)
            // //  BaseTextLine('total remain?',transactionNumberSelected.totalRemain.toString()),

            // SizedBox(height: getProportionateScreenHeight(kLarge)),

            BaseTextLine('Remarks', transactionNumberSelected.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
           
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, transactionNumberSelected),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<ProductionIssueItemProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or Scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value.toUpperCase());
          if (item.fgBatch == 'Y') {
          Navigator.of(context)
              .pushNamed(ProductionIssueItemBatch.routeName, arguments: item);
        } else {
              if(item.putQty > 0){
             print('masuk');
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
                        Text('You Already Put Qty'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        Text(item.putQty.toString()),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        Text('You want to re-enter qty ?'),

                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('Put New Qty'),
                            onPressed: () {
                               final itemNumberProvider =
                  Provider.of<ProductionIssueNumberProvider>(context,
                      listen: false);
           itemNumberProvider.selected.totalItem =
                    itemNumberProvider.selected.totalItem  +
                        1;
                               Navigator.of(context).pop();
                              showModalBottomSheet(
                              context: context,
                              builder: (_) => ProductionIssueItemNonBatchDialog(item));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                  },
              );

              }else{
                  showModalBottomSheet(
                  context: context,
                  builder: (_) => ProductionIssueItemNonBatchDialog(item));
              }
          
        }
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionIssueNumberModel item) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, item.pickNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ProductionIssueItemProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProductionIssueItemList(provider.items[index]),
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
