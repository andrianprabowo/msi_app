import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_all_transaction_model.dart';
import 'package:msi_app/providers/list_prod_issue_rm_detail_provider.dart';
import 'package:msi_app/providers/production_issue_all_transaction_provider.dart';
import 'package:msi_app/screens/prod_list_issue_rm_detail/widgets/item_prod_issue_rm_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListIssueRawRmDetailScreen extends StatelessWidget {
  static const routeName = '/list_issue_rm_detail';

  Future<void> refreshData(BuildContext context, ProductionIssueAllTransactionModel item) async {
    await Provider.of<ListProdIssueRmDetailProvider>(context, listen: false)
        .getAllData(item.idIssueRmHeader);
  }

  @override
  Widget build(BuildContext context) {
    final detail =
        Provider.of<ProductionIssueAllTransactionProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Issue (Raw Material)'),
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

  Widget buildItemList(BuildContext context, ProductionIssueAllTransactionModel itemPo) {
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
            child: Consumer<ListProdIssueRmDetailProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemProductionIssueRmDetail(
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
