import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/providers/item_po_batch_provider.dart';
import 'package:msi_app/screens/receipt_batch/widgets/dialog_input_qty.dart';
import 'package:msi_app/screens/receipt_batch/widgets/item_batch.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ReceiptBatchScreen extends StatelessWidget {
  static const routeName = '/receipt_batch';

  Future<void> refreshData(
    BuildContext context,
    String docNum,
    String itemCode,
  ) async {
    await Provider.of<ItemPoBatchProvider>(context, listen: false)
        .getPoDetailByDocNumAndItemCode(docNum, itemCode);
  }

  @override
  Widget build(BuildContext context) {
    ItemPurchaseOrder item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Item Batch'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('PO Number', item.docNum),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Document Date', convertDate(DateTime.now())),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Batch'),
            Divider(),
            buildItemList(context, item),
          ],
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, ItemPurchaseOrder item) {
    return Expanded(
      child: FutureBuilder(
        future: refreshData(context, item.docNum, item.itemCode),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return RefreshIndicator(
            onRefresh: () => refreshData(context, item.docNum, item.itemCode),
            child: Consumer<ItemPoBatchProvider>(
              builder: (_, provider, child) => provider.items.length == 0
                  ? NoData()
                  : ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.items[index],
                          child: ItemBatch(provider.items[index]),
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
    final provider = Provider.of<ItemPoBatchProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => DialogInputQty(item),
        );
      },
    );
  }
}
