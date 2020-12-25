import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_provider.dart';
import 'package:msi_app/screens/production_receipt_item/production_receipt_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionReceiptNumberList extends StatelessWidget {
  final ProductionReceiptModel item;

  const ProductionReceiptNumberList(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final poProvider =
        Provider.of<ProductionReceiptProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        poProvider.selectPo(item);
        authProvider.clearBin();
        Navigator.of(context).pushNamed(ProductionReceiptItem.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Production Number', item.poNumber),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            BaseTextLine('Memo', item.vendorName),
            BaseTextLine('Whs Code', authProvider.warehouseId),
            BaseTextLine('Whs Name', authProvider.warehouseName)
          ],
        ),
      ),
    );
  }
}
