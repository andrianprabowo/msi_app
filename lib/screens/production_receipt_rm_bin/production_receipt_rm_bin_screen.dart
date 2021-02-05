import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_item_list_model.dart';
import 'package:msi_app/providers/production_receipt_rm_bin.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_bin/widget/item_prod_rm_bin.dart';
import 'package:msi_app/screens/production_receipt_rm_item/production_receipt_rm_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRmBinScreen extends StatelessWidget {
  static const routeName = '/production_receipt_rm_bin';

  Future<void> refreshData(BuildContext context, String itemCode) async {
    // final header = Provider.of<ProductionReceiptRMNumberListProvider>(context,
    // listen: false)
    // .selected;
    // final card = header.cardCode;
    final pickItemProvider =
        Provider.of<ProductionReceiptRMBinProvider>(context, listen: false);
    await pickItemProvider.getPlBinList(itemCode);
  }

  @override
  Widget build(BuildContext context) {
    final pickList = Provider.of<ProductionReceiptRMNumberListProvider>(context,
            listen: false)
        .selected;
    ProductionReceiptRMItemListModel pickItemReceive =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProductionReceiptRMBinProvider>(
              builder: (_, provider, child) {
                String binLoc = provider.recBin ?? '';
                return BaseTextLine('Recommendation Bin', binLoc);
              },
            ),
            // BaseTextLine('Recommendation Bin', ''),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Memo', pickList.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context, pickItemReceive),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            Row(
              children: [
                Expanded(
                  child: BaseTitle('List Bin Location'),
                ),
                Text('Show All Bin'),
                Consumer<ProductionReceiptRMBinProvider>(
                  builder: (_, provider, child) {
                    return Switch(
                      value: provider.showAllBin,
                      onChanged: (value) {
                        provider.toggleStatus();
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(),
            buildItemList(context, pickItemReceive),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(
      BuildContext context, ProductionReceiptRMItemListModel item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.itemCode),
            child: Consumer<ProductionReceiptRMBinProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemProdRmBin(item, provider.items[index]),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(
      BuildContext context, ProductionReceiptRMItemListModel pickItemReceive) {
    final provider =
        Provider.of<ProductionReceiptRMBinProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Location',
      hint: 'Scan Bin Location',
      scanResult: (value) {
        final item = provider.findByBinLocation(value);
        // Navigator.of(context).pushNamed(
        //   PickItemBatchScreen.routeName,
        //   arguments: {
        //     'pickItemReceive': pickItemReceive,
        //     'pickListBin': item,
        //   },
        // );

        // if (pickItemReceive.fgBatch == 'Y')
        //   Navigator.of(context).pushNamed(
        //     PickItemBatchScreen.routeName,
        //     arguments: {
        //       'pickItemReceive': pickItemReceive,
        //       'pickListBin': item,
        //     },
        //   );
        // else {
        //   pickItemReceive.itemStorageLocation = item.binLocation;
        //   Navigator.of(context)
        //       .popUntil(ModalRoute.withName(PickItemReceiveScreen.routeName));

        pickItemReceive.itemStorageLocation = item.binLocation;
        Navigator.of(context)
            .popUntil(ModalRoute.withName(ProductionReceiptRMItem.routeName));
        // }
      },
    );
  }
}
