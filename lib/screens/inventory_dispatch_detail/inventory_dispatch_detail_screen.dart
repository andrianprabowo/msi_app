import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_detail.dart';
import 'package:msi_app/providers/inventory_dispatch_header_provider.dart';
import 'package:msi_app/screens/inventory_dispatch_detail/widgets/item_inventory_dispatch_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:provider/provider.dart';

class InventoryDispatchDetailScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_detail';
  final _scanInputZonation = TextEditingController();

  final List<InventoryDispatchDetail> items = [
    InventoryDispatchDetail(
      itemCode: '150308200MSI-Code1',
      itemName: '150308200MSI-Item name 1',
      totalToPick: 100.00,
      remainingQty: 100.00,
      inventoryUom: 'pcs',
      batchNumber: 0,
    ),
    InventoryDispatchDetail(
      itemCode: '150308200MSI-Code2',
      itemName: '150308200MSI-Item name 2',
      totalToPick: 100.00,
      remainingQty: 100.00,
      inventoryUom: 'pcs',
      batchNumber: 0,
    ),
    InventoryDispatchDetail(
      itemCode: '150308200MSI-Code3',
      itemName: '150308200MSI-Item name 3',
      totalToPick: 100.00,
      remainingQty: 100.00,
      inventoryUom: 'pcs',
      batchNumber: 0,
    ),
    InventoryDispatchDetail(
      itemCode: '150308200MSI-Code4',
      itemName: '150308200MSI-Item name 4',
      totalToPick: 100.00,
      remainingQty: 100.00,
      inventoryUom: 'pcs',
      batchNumber: 0,
    ),
    InventoryDispatchDetail(
      itemCode: '150308200MSI-Code5',
      itemName: '150308200MSI-Item name 5',
      totalToPick: 100.00,
      remainingQty: 100.00,
      inventoryUom: 'pcs',
      batchNumber: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final invDisHeader =
        Provider.of<InventoryDispatchHeaderProvider>(context, listen: false);
    final item = invDisHeader.header;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Dispatch'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Doc Number', item.docNumber),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Document Date', convertDate(item.requireDate)),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            TextFormField(
              controller: _scanInputZonation,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Memo',
                hintText: 'Input Memo',
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Outlet', item.toWarehouse),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTextLine('Zonation', invDisHeader.zonation),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            buildInputScan(context),
            SizedBox(height: getProportionateScreenHeight(kMedium)),
            BaseTitle('List Inventory Transfer'),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return ItemInventoryDispatchDetail(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    // final poProvider =
    //     Provider.of<PurchaseOrderProvider>(context, listen: false);
    return InputScan(
      label: 'Bin Container',
      hint: 'Input or scan Bin',
      scanResult: (value) {
        // final po = poProvider.findByPoNumber(value);
        // Navigator.of(context).pushNamed(
        //   ReceiptDetailScreen.routeName,
        //   arguments: po,
        // );
      },
    );
  }
}
