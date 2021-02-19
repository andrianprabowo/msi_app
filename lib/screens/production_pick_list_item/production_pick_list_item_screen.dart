import 'package:flutter/material.dart';
import 'package:msi_app/models/production_pick_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_pick_list_item_provider.dart';
import 'package:msi_app/providers/production_pick_list_provider.dart';
import 'package:msi_app/screens/production_pick_list_bin/production_pick_list_bin_screen.dart';
import 'package:msi_app/screens/production_pick_list_final_check/production_pick_list_final_check_screen.dart';
import 'package:msi_app/screens/production_pick_list_item/widgets/production_pick_list_item_list.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionPickListItem extends StatelessWidget {
  static const routeName = '/production_pick_list_item';

  Future<void> refreshData(BuildContext context, String pickNumber) async {
    final pickItemProvider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
    await pickItemProvider.getPlActionByPlNo(pickNumber);

    final pickWhsProvider =
        Provider.of<ProductionPickListProvider>(context, listen: false);
    pickWhsProvider.selected.pickItemList = pickItemProvider.items;
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ProductionPickListProvider>(context, listen: false)
        .selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    /* final pickItemProvider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
    var status = 0; */
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick List'),
        actions: [
          IconButton(
              icon: Icon(Icons.post_add),
              onPressed: () {
                authProvider.clearBin();
                Navigator.of(context)
                    .pushNamed(ProductionPickListFinalCheck.routeName);
                /* for (var i = 0; i < pickItemProvider.items.length; i++) {
                  if (pickItemProvider.items[i].itemStorageLocation != '' &&
                      pickItemProvider.items[i].pickedQty.toStringAsFixed(2) !=
                          '0.00') 
                    status = 1;
                }
                if (status == 1) {
                  authProvider.clearBin();
                  Navigator.of(context)
                      .pushNamed(ProductionPickListFinalCheck.routeName);
                } else {
                  showAlertOnZero(context);
                } */
              })
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.symmetric(vertical: kLarge, horizontal: kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Pick Number', item.pickNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Pick Date', convertDate(item.pickDate)),
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
    final provider =
        Provider.of<ProductionPickListItemProvider>(context, listen: false);
    return InputScan(
      label: 'Item Code',
      hint: 'Input or Scan Item',
      scanResult: (value) {
        final item = provider.findByItemCode(value.toUpperCase());
        item.fgBatch == "Y"
            ? Navigator.of(context)
                .pushNamed(ProductionPickListBin.routeName, arguments: item)
            // : showModalBottomSheet(
            //     context: context,
            //     builder: (_) => ProductionPickListItemNonBatchDialog(item));
            : Navigator.of(context)
                .pushNamed(ProductionPickListBin.routeName, arguments: item);
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionPickListModel item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.pickNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.pickNumber),
            child: Consumer<ProductionPickListItemProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child:
                              ProductionPickListItemList(provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  /* Future<void> showAlertOnZero(BuildContext context) async {
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
              Text('Please Select at Least 1 Item & 1 Bin'),
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
  } */
}
