import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/screens/receipt_vendor/widgets/item_receipt.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class ReceiptVendorScreen extends StatelessWidget {
  static const routeName = '/receipt_vendor';
  final _scanInput = TextEditingController();

  List<PurchaseOrder> items = [
    PurchaseOrder(
      poNumber: 'PO-11111',
      docDate: DateTime.now(),
      vendor: 'PT Sinar Mas Land',
      warehouse: 'Jakarta Main Warehouse',
    ),
    PurchaseOrder(
      poNumber: 'PO-22222',
      docDate: DateTime.now(),
      vendor: 'PT Sinar Mas Land',
      warehouse: 'Sentul Main Warehouse',
    ),
    PurchaseOrder(
      poNumber: 'PO-33333',
      docDate: DateTime.now(),
      vendor: 'PT Sinar Mas Land',
      warehouse: 'Jakarta Main Warehouse',
    ),
    PurchaseOrder(
      poNumber: 'PO-44444',
      docDate: DateTime.now(),
      vendor: 'PT Sinar Mas Land',
      warehouse: 'Sentul Main Warehouse',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt From Vendor'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _scanInput,
              decoration: InputDecoration(
                hintText: 'Input or scan PO Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.local_see),
                  onPressed: () {
                    _scanInput.text = 'PO-1234';
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            Text(
              'List Purchase Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  Divider();
                  return ItemReceipt(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
