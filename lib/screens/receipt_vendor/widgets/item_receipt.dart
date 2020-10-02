import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/screens/receipt_detail/receipt_detail_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:provider/provider.dart';

class ItemReceipt extends StatelessWidget {
  final PurchaseOrder item;

  const ItemReceipt(this.item);

  String get dateString {
    return DateFormat.yMMMMd().format(item.docDate);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ReceiptDetailScreen.routeName,
          arguments: item.poNumber,
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('PO Number', item.poNumber),
            buildRow('Doc Date', dateString),
            buildRow('Vendor', item.vendorName),
            FutureBuilder(
              future: authProvider.initPrefs(),
              builder: (_, snapshot) {
                return buildRow('Warehouse', authProvider.warehouseName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(value)
      ],
    );
  }
}
