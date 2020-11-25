import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_number_list_model.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/production_receipt_rm_number_list_provider.dart';
import 'package:msi_app/screens/production_receipt_rm_item/production_receipt_rm_item_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMNumberList extends StatelessWidget {
  final ProductionReceiptRMNumberListModel item;

  const ProductionReceiptRMNumberList(this.item);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final inventoryDispatchDetailProvider =
        Provider.of<ProductionReceiptRMNumberListProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        inventoryDispatchDetailProvider.selectPickList(item);
        Navigator.of(context).pushNamed(ProductionReceiptRMItem.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(kTiny),
        padding: const EdgeInsets.all(kSmall),
        decoration: kBoxDecoration,
        child: Column(
          children: [
            BaseTextLine('Doc Number', item.docNumber),
            BaseTextLine('Doc Date', convertDate(item.docDate)),
            BaseTextLine('Whs Code', item.cardCode),
            BaseTextLine('Whs Name', item.cardName),
            BaseTextLine('Picker', authProvider.username),
            BaseTextLine('Memo', item.pickRemark),
          ],
        ),
      ),
    );
  }
}
