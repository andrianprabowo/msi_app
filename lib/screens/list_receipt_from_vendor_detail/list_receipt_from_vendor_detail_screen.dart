import 'package:flutter/material.dart';
import 'package:msi_app/models/list_good_receipt_po.dart';
import 'package:msi_app/providers/list_grpo_detail_provider.dart';
import 'package:msi_app/providers/list_grpo_provider.dart';
import 'package:msi_app/screens/list_receipt_from_vendor_detail/widgets/item_list_receipt_from_vendor_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ListReceiptFromVendorDetailScreen extends StatelessWidget {
  static const routeName = '/list_receipt_from_vendor_detail';

  Future<void> refreshData(BuildContext context, ListGoodReceiptPo item) async {
    await Provider.of<ListGrpoDetailProvider>(context, listen: false)
        .getAllData(item.idGrpo);
  }

  @override
  Widget build(BuildContext context) {
    final detail =
        Provider.of<ListGrpoProvider>(context, listen: false).selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Receipt From Vendor'),
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

  Widget buildItemList(BuildContext context, ListGoodReceiptPo itemPo) {
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
            child: Consumer<ListGrpoDetailProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemListReceiptFromVendorDetail(
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
