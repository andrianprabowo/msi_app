import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_all_transaction_model.dart';
import 'package:msi_app/providers/list_pick_list_prod_receipt_detail_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_all_transaction_provider.dart';
import 'package:msi_app/screens/prod_list_pick_list_detail_receipt/widgets/prod_item_list_pick_list_detail_receipt.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProdListPickListDetailReceiptScreen extends StatelessWidget {
  static const routeName = '/prod_list_pick_list_detail_receipt';

  Future<void> refreshData(BuildContext context, ProductionReceiptRMAllTransactionModel item) async {
    await Provider.of<ListPickListProdReceiptDetailProvider>(context, listen: false)
        .getAllData(item.idPutAwyProdHeader);
  }

  @override
  Widget build(BuildContext context) {
    final detail =
        Provider.of<ProductionReceiptRMAllTransactionProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Receipt Submitted'),
        actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             BaseTitle('Cancel This Transaction'),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
           
            // Divider(),
            buildItemList(context, detail),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ProductionReceiptRMAllTransactionModel itemPo) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, itemPo),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, itemPo),
            child: Consumer<ListPickListProdReceiptDetailProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProdItemListPickListDetailReceipt(
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
