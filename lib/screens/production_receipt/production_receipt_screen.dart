import 'package:flutter/material.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_provider.dart';
import 'package:msi_app/screens/home/home_screen.dart';
import 'package:msi_app/screens/production_receipt/widgets/production_receipt_number_list.dart';
import 'package:msi_app/screens/production_receipt_all_transaction/production_receipt_all_transaction_screen.dart';
import 'package:msi_app/screens/production_receipt_item/production_receipt_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceipt extends StatelessWidget {
  static const routeName = '/production_receipt';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<ProductionReceiptProvider>(context, listen: false)
        .getAllPoByWarehouseId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Finish Goods'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ProductionReceiptAllTransaction.routeName);
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
            BaseTitle('List Purchase Order'),
            Divider(),
            buildItemList(context),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<ProductionReceiptProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InputScan(
      label: 'Production Number',
      hint: 'Input or Scan Production Number',
      scanResult: (value) {
        final item = provider.findByPoNumber(value.toUpperCase());
        provider.selectPo(item);
        authProvider.clearBin();
        authProvider.clearGl();
        Navigator.of(context).pushNamed(ProductionReceiptItem.routeName);
      },
    );
  }

  Widget buildItemList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context),
            child: Consumer<ProductionReceiptProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProductionReceiptNumberList(
                              provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
