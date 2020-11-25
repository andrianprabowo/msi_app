import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order_rfo.dart';
import 'package:msi_app/providers/receipt_batch_rfo_provider.dart';
import 'package:msi_app/screens/receipt_batch_rfo/widgets/dialog_receipt_batch_rfo.dart';
import 'package:msi_app/screens/receipt_batch_rfo/widgets/item_batch_receipt_rfo.dart';
import 'package:msi_app/screens/receipt_detail_rfo/receipt_detail_rfo_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ReceiptBatchRfoScreen extends StatelessWidget {
  static const routeName = '/receipt_batch_rfo_sc';

  Future<void> fetchData(
    BuildContext context,
    String itemCode,
    String cardCode,
  ) async {
    final provider = Provider.of<ReceiptBatchRfoProvider>(context, listen: false);
    await provider.getBatchListByItemWarehouse(itemCode, cardCode);
  }

  @override
  Widget build(BuildContext context) {
    final itemBatchProvider =
        Provider.of<ReceiptBatchRfoProvider>(context, listen: false);
        
        
    ItemPurchaseOrderRfo item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('----------------------'),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(
                ReceiptDetailRfoScreen.routeName,
                arguments: item,
              );
            },
          )
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
            Row(
              children: [
                Consumer<ReceiptBatchRfoProvider>(
                    builder: (BuildContext _, provider, Widget child) {
                  return Expanded(
                    child: BaseTextLine(
                      'Total Picked',
                      provider.totalPicked.toStringAsFixed(2),
                    ),
                  );
                }),
                SizedBox(width: getProportionateScreenWidth(kLarge)),
                FlatButton.icon(
                    onPressed: () {
                      itemBatchProvider.clear();
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    label: Text('CLEAR'))
              ],
            ),
            BaseTitle(item.itemCode),
            BaseTitle(item.description),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Batch of Item'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ItemPurchaseOrderRfo item) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, item.itemCode, item.cardCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ReceiptBatchRfoProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemBatchReceiptBatchRfo(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ReceiptBatchRfoProvider>(context, listen: false);
    return InputScan(
      label: 'Batch Number',
      hint: 'Input or scan Batch Number',
      scanResult: (value) {
        final item = provider.findByBatchNo(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogReceiptBatchRfo(item),
        );
      },
    );
  }
}
