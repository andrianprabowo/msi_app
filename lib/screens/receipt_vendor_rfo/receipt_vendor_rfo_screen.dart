import 'package:flutter/material.dart';
import 'package:msi_app/providers/purchase_order_provider.dart';
import 'package:msi_app/providers/purchase_order_rfo_provider.dart';
import 'package:msi_app/screens/receipt_detail/receipt_detail_screen.dart';
import 'package:msi_app/screens/receipt_vendor_rfo/item_receipt_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ReceiptVendorRfoScreen extends StatelessWidget {
  static const routeName = '/receipt_vendor_rfo';

  Future<void> refreshData(BuildContext context) async {
    await Provider.of<PurchaseOrderRfoProvider>(context, listen: false)
        .getAllPoByWarehouseId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Return from Outlet'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              // Navigator.of(context)
              //     .pushNamed(ListReceiptFromVendorScreen.routeName);
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
            child: Consumer<PurchaseOrderRfoProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemReceiptRfo(provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<PurchaseOrderProvider>(context, listen: false);
    return InputScan(
      label: 'PO Number',
      hint: 'Input or scan PO Number',
      scanResult: (value) {
        final item = provider.findByPoNumber(value);
        provider.selectPo(item);
        Navigator.of(context).pushNamed(ReceiptDetailScreen.routeName);
      },
    );
  }
}
