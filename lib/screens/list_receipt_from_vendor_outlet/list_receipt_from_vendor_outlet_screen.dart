import 'package:flutter/material.dart';
import 'package:msi_app/providers/list_grpo_outlet_provider.dart';
import 'package:msi_app/screens/list_receipt_from_vendor_outlet/widgets/item_list_receipt_from_vendor_outlet.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListReceiptFromVendorOutletScreen extends StatelessWidget {
  static const routeName = '/list_receipt_from_vendor_outlet';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<ListGrpoOutletProvider>(context, listen: false)
        .getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Receipt From Outlet'),
        actions: [
        
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
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Good Receipt PO'),
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
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context),
            child: Consumer<ListGrpoOutletProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemListReceiptFromVendorOutlet(provider.items[index]),
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
