import 'package:flutter/material.dart';
import 'package:msi_app/models/production_issue_model.dart';
import 'package:msi_app/providers/production_issue_number_provider.dart';
import 'package:msi_app/providers/production_issue_provider.dart';
import 'package:msi_app/screens/production_issue_item/production_issue_item_screen.dart';
import 'package:msi_app/screens/production_issue_number/widgets/production_issue_number_list.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionIssueNumber extends StatelessWidget {
  static const routeName = '/production_issue_number';

  Future<void> refreshData(BuildContext context, String binCode) async {
    final productionIssueNumberProvider =
        Provider.of<ProductionIssueNumberProvider>(context, listen: false);
    await productionIssueNumberProvider.getTransactionNumber(binCode);
  }

  @override
  Widget build(BuildContext context) {
    final productionIssueNumberSelected =
        Provider.of<ProductionIssueProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('Issue (Raw Material)'),
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
            BaseTitle('List Production Order'),
            Divider(),
            buildItemList(context, productionIssueNumberSelected),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ProductionIssueNumberProvider>(context, listen: false);
    return InputScan(
      label: 'Production Number',
      hint: 'Input or Scan Production Number',
      scanResult: (value) {
        final item = provider.findByPickNumber(value);
        
        provider.selectPickList(item);
        Navigator.of(context).pushNamed(
          ProductionIssueItem.routeName,
          arguments: item,
        );
      },
    );
  }

  Widget buildItemList(BuildContext context, ProductionIssueModel item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.binCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.binCode),
            child: Consumer<ProductionIssueNumberProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ProductionIssueNumberList(provider.items[index]),
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
