import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order_rfo.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/purchase_order_rfo_provider.dart';
import 'package:msi_app/screens/receipt_detail_rfo/receipt_detail_rfo_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ItemReceiptRfo extends StatelessWidget {
  final PurchaseOrderRfo item;

  const ItemReceiptRfo(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider =
        Provider.of<PurchaseOrderRfoProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        poProvider.selectPo(item);
        authProvider.clearBin();
        Navigator.of(context).pushNamed(ReceiptDetailRfoScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Doc Number', item.poNumber),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            BaseTextLine('Outlet', item.vendorName),
            BaseTextLine('Warehouse', authProvider.warehouseName)
          ],
        ),
      ),
    );
  }
}
