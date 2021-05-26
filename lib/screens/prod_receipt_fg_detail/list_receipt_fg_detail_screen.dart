import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_all_transaction_model.dart';
import 'package:msi_app/providers/list_prod_receipt_fg_detail_provider.dart';
import 'package:msi_app/providers/production_receipt_all_transaction_provider.dart';
import 'package:msi_app/screens/prod_receipt_fg_detail/widgets/item_prod_receipt_fg_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListReceiptFgDetailScreen extends StatelessWidget {
  static const routeName = '/list_receipt_fg_detail';

  Future<void> refreshData(BuildContext context, ProductionReceiptAllTransactionModel item) async {
    await Provider.of<ListProdReceiptFgDetailProvider>(context, listen: false)
        .getAllData(item.idGrpofgHeader);
  }

  @override
  Widget build(BuildContext context) {
    final detail =
        Provider.of<ProductionReceiptAllTransactionProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Receipt Finish Goods'),
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

  Widget buildItemList(BuildContext context, ProductionReceiptAllTransactionModel itemPo) {
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
            child: Consumer<ListProdReceiptFgDetailProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemProdReceiptFgDetail(
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
