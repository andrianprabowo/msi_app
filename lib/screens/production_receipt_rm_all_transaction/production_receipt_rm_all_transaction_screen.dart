import 'package:flutter/material.dart';
import 'package:msi_app/providers/production_receipt_rm_all_transaction_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_all_transaction/widgets/production_receipt_rm_all_transaction_list.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMAllTransaction extends StatelessWidget {
  static const routeName = '/production_receipt_rm_all_transaction';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<ProductionReceiptRMAllTransactionProvider>(context, listen: false)
        .getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Receipt (Raw Material) Submitted'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Receipt (Raw Material)'),
            Divider(),
            buildItemList(context),
          ],
        ),
      ),
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
                  child: Consumer<ProductionReceiptRMAllTransactionProvider>(
                    builder: (_, provider, child) => provider.items.length == 0
                        ? NoData()
                        : ListView.builder(
                            itemCount: provider.items.length,
                            itemBuilder: (_, index) {
                              return ChangeNotifierProvider.value(
                                value: provider.items[index],
                                child: ProductionReceiptRMAllTransactionList(provider.items[index]),
                              );
                            }),
                  ),
                  onRefresh: () => refreshData(context));
            }));
  }
}
