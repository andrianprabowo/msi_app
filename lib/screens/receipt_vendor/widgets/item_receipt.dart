import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/purchase_order_provider.dart';
import 'package:msi_app/screens/receipt_detail/receipt_detail_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemReceipt extends StatelessWidget {
  final PurchaseOrder item;

  const ItemReceipt(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider =
        Provider.of<PurchaseOrderProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        poProvider.selectPo(item);
        Navigator.of(context).pushNamed(ReceiptDetailScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('PO Number', item.poNumber),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            BaseTextLine('Vendor', item.vendorName),
            BaseTextLine('Warehouse', authProvider.warehouseName)
          ],
        ),
      ),
    );
  }
}
