import 'package:flutter/material.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_item/production_receipt_rm_item_screen.dart';
import 'package:msi_app/screens/production_receipt_rm_number/widgets/production_receipt_rm_number_list.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMNumber extends StatelessWidget {
  static const routeName = '/production_receipt_rm_number';

  Future<void> refreshData(BuildContext context) async {
    final headerProvider =
        Provider.of<ProductionReceiptRMProvider>(context, listen: false);
    final provider = Provider.of<ProductionReceiptRMNumberListProvider>(context,
        listen: false);
    final item = headerProvider.selected;
    print(item);
    // provider.getPlByWarehouse('WMSISTPR-SYSTEM-BIN-LOCATION');
   await provider.getPlByWarehouse(item.binCode);
    // print('object$item');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receipt')),
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
            BaseTitle('List'),
            Divider(),
            buildItemList(context),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ProductionReceiptRMNumberListProvider>(context,
        listen: false);
    return InputScan(
      label: 'Receipt',
      hint: 'Input or scan Receipt',
      scanResult: (value) {
        final item = provider.findByDocNumber(value.toUpperCase());
        provider.selectPickList(item);
        Navigator.of(context).pushNamed(ProductionReceiptRMItem.routeName);
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
            child: Consumer<ProductionReceiptRMNumberListProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProductionReceiptRMNumberList(
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
