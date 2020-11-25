import 'package:flutter/material.dart';
import 'package:msi_app/providers/production_pick_list_provider.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/production_pick_list/widgets/production_pick_list_picker.dart';
import 'package:msi_app/screens/production_pick_list_item/production_pick_list_item_screen.dart';
import 'package:msi_app/screens/production_pick_list_all_transaction/production_pick_list_all_transaction_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionPickList extends StatelessWidget {
  static const routeName = '/production_pick_list';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<ProductionPickListProvider>(context, listen: false)
        .getPlByWarehouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick List (Raw Material)'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context).pushNamed(ProductionPickListAllTransaction.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home, color: Colors.green, size: 50),
                        Divider(),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
                        Text('Back To Home'),
                        SizedBox(height: getProportionateScreenHeight(kLarge)),
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
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeScreen.routeName, (route) => false);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
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
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Pick List (Raw Material)'),
            Divider(),
            buildItemList(context),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ProductionPickListProvider>(context, listen: false);
    return InputScan(
      label: 'Pick Number',
      hint: 'Input or Scan Pick Number',
      scanResult: (value) {
        final item = provider.findByPickNumber(value.toUpperCase());
        provider.selectPickList(item);
        Navigator.of(context).pushNamed(ProductionPickListItem.routeName);
      },
    );
  }

  Widget buildItemList(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: refreshData(context),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) return ErrorInfo();

              return RefreshIndicator(
                  child: Consumer<ProductionPickListProvider>(
                    builder: (_, provider, child) => provider.items.length == 0
                        ? NoData()
                        : ListView.builder(
                            itemCount: provider.items.length,
                            itemBuilder: (_, index) {
                              return ChangeNotifierProvider.value(
                                value: provider.items[index],
                                child: ProductionPickListPicker(provider.items[index]),
                              );
                            }),
                  ),
                  onRefresh: () => refreshData(context));
            }));
  }
}
