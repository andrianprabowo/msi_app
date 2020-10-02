import 'package:flutter/material.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/screens/receipt_detail/widgets/dialog_lot_number.dart';
import 'package:msi_app/utils/constants.dart';

class ItemDetail extends StatelessWidget {
  final ItemPurchaseOrder item;

  const ItemDetail(this.item);

  void _inputLotNumber(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return DialogLotNumber();
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _inputLotNumber(context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow('Item Code', item.itemCode),
            buildRow('Item Name', item.itemName),
            buildRow('Total Receipt', item.totalReceipt.toStringAsFixed(2)),
            buildRow('Receipt Qty', item.receiptQty.toStringAsFixed(2)),
            buildRow('Remaining Qty', item.remainingQty.toStringAsFixed(2)),
            buildRow('UoM', item.uom),
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
