import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/item_po_provider.dart';
import 'package:msi_app/providers/purchase_order_provider.dart';
import 'package:msi_app/screens/receipt_check/receipt_check_screen.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_input_non_batch.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_input_qty.dart';
import 'package:msi_app/screens/receipt_detail/widgets/item_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/error_info.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/item_bin.dart';
import 'package:msi_app/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ReceiptDetailScreen extends StatelessWidget {
  static const routeName = '/receipt_detail';

  Future<void> fetchData(BuildContext context, String docNum) async {
    final itemPoProvider = Provider.of<ItemPoProvider>(context, listen: false);
    await itemPoProvider.getPoDetailByDocNum(docNum);

    final poProvider =
        Provider.of<PurchaseOrderProvider>(context, listen: false);
    poProvider.selected.detailList = itemPoProvider.items;
  }

  void createReceiptVendor(BuildContext context) {
    Provider.of<PurchaseOrderProvider>(context, listen: false)
        .createReceiptVendor();
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final poProvider =
        Provider.of<PurchaseOrderProvider>(context, listen: false);
    final po = poProvider.selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Receipt From Vendor'),
        actions: [
          IconButton(
              icon: Icon(Icons.post_add),
              onPressed: () {
                if (authProvider.binId == 'Please Select Bin') {
                  final snackBar = SnackBar(
                    content: Row(
                      children: [ 
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: getProportionateScreenWidth(kLarge)),
                        Text('Please Select Bin First'),
                      ],
                    ),
                  );
                  globalKey.currentState.showSnackBar(snackBar);
                  return;
                }

                Navigator.of(context).pushNamed(ReceiptCheckScreen.routeName);
              })
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
            ItemBin(),
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

  Widget buildItemList(BuildContext context, PurchaseOrder po) {
    return Expanded(
      child: FutureBuilder(
        future: fetchData(context, po.poNumber),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return ErrorInfo();

          return Consumer<ItemPoProvider>(
            builder: (_, provider, child) => provider.items.length == 0
                ? NoData()
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (_, index) {
                      return ChangeNotifierProvider.value(
                        value: provider.items[index],
                        child: ItemDetail(provider.items[index]),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider = Provider.of<ItemPoProvider>(context, listen: false);
    return InputScan(
      label: 'Item Barcode',
      hint: 'Input or scan Item Barcode',
      scanResult: (value) {
        final item = provider.findByItemCode(value);
        showModalBottomSheet(
          context: context,
          builder: (_) => item.fgBatch == 'Y'
              ? DialogInputQty(item)
              : DialogInputQtyNonBatch(item),
        );
      },
    );
  }

  Widget buildInputScanbin(
      BuildContext context, PurchaseOrderProvider poProvider) {
    return InputScan(
      label: 'Staging Bin',
      hint: 'Input or scan Staging Bin',
      scanResult: (value) {
        poProvider.setStagingBin(value);
      },
      
    );
  }
}
