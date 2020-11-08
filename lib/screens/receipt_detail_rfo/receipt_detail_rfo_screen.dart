import 'package:flutter/material.dart';
import 'package:msi_app/widgets/item_bin_rfo.dart';
import 'package:msi_app/models/purchase_order_rfo.dart';
import 'package:msi_app/providers/item_po_provider_rfo.dart';
import 'package:msi_app/providers/purchase_order_rfo_provider.dart';
import 'package:msi_app/screens/receipt_check_rfo/receipt_check_rfo_screen.dart';
import 'package:msi_app/screens/receipt_detail_rfo/widgets/dialog_input_non_batch_rfo.dart';
import 'package:msi_app/screens/receipt_detail_rfo/widgets/dialog_input_qty_rfo.dart';
import 'package:msi_app/screens/receipt_detail_rfo/widgets/item_detail_rfo.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ReceiptDetailRfoScreen extends StatelessWidget {
  static const routeName = '/receipt_detail_rfo';

  Future<void> fetchData(BuildContext context, String docNum) async {
    final itemPoProvider =
        Provider.of<ItemPoRfoProvider>(context, listen: false);
    await itemPoProvider.getPoDetailByDocNum(docNum);

    final poProvider =
        Provider.of<PurchaseOrderRfoProvider>(context, listen: false);
    poProvider.selected.detailList = itemPoProvider.items;
  }

  void createReceiptVendor(BuildContext context) {
    Provider.of<PurchaseOrderRfoProvider>(context, listen: false)
        .createReceiptVendor();
  }

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<PurchaseOrderRfoProvider>(context, listen: false);
    final po = poProvider.selected;

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Return from Outlet'),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () => Navigator.of(context)
                .pushNamed(ReceiptCheckRfoScreen.routeName),
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
            BaseTextLine('PO Number', po.poNumber),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Document Date', convertDate(po.docDate)),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            ItemBinRfo(),
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

  Widget buildItemList(BuildContext context, PurchaseOrderRfo po) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, po.poNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ItemPoRfoProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemDetailRfo(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ItemPoRfoProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQtyRfo(item)
              : DialogInputQtyNonBatchRfo(item),
        );
      },
    );
  }

  Widget buildInputScanbin(
      BuildContext context, PurchaseOrderRfoProvider poProvider) {
    return InputScan(
      label: 'Staging Bin',
      hint: 'Input or scan Staging Bin',
      scanResult: (value) {
        poProvider.setStagingBin(value);
      },
    );
  }
}
