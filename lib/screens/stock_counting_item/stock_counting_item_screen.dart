import 'package:flutter/material.dart';
import 'package:msi_app/models/stock_counting_header.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/stock_counting_header_provider.dart';
import 'package:msi_app/providers/stock_counting_item_provider.dart';
import 'package:msi_app/screens/receipt_check/receipt_check_screen.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_non_batch_sc.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/dialog_input_qty_sc.dart';
import 'package:msi_app/screens/stock_counting_item/widgets/item_detail_sc.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class StockCountingItemScreen extends StatelessWidget {
  static const routeName = '/stock_counting_item';

  Future<void> fetchData(BuildContext context, String docNum) async {
    final itemPoProvider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    await itemPoProvider.getScDetailByDocNum(docNum);

    final poProvider =
        Provider.of<StockCountingHeaderProvider>(context, listen: false);
    poProvider.selected.detailList = itemPoProvider.item;
  }
  

  void createReceiptVendor(BuildContext context) {
    Provider.of<StockCountingHeaderProvider>(context, listen: false)
        .createReceiptVendor();
  }

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<StockCountingHeaderProvider>(context, listen: false);
    final authProvider =
        Provider.of<AuthProvider>(context, listen: false);
        
    final po = poProvider.selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Toko Card'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () =>
                Navigator.of(context).pushNamed(ReceiptCheckScreen.routeName),
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
            BaseTextLine('Inventory Count No', po.poNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Counting Date', convertDate(po.docDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            // ItemBin(),
            BaseTextLine('Stock Counter', authProvider.username),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Warehouse', authProvider.warehouseName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Items'),
            Divider(),
            buildItemList(context, po),
          ],
        ),
      ),
    );
  }

   Widget buildItemList(BuildContext context, StockCountingHeader po) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, po.poNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<StockCountingItemProvider>(
            builder: (_, provider, child) => provider.item.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.item.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.item[index],
                        child: ItemDetailSc(provider.item[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<StockCountingItemProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQtySc(item)
              : DialogInputQtyNonBatchSc(item),
        );
      },
    );
  }
}
