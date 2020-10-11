import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_dispatch_header.dart';
import 'package:msi_app/providers/inventory_dispatch_header_provider.dart';
import 'package:msi_app/screens/inventory_dispatch/widgets/item_inventory_dispatch_header.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:provider/provider.dart';

class InventoryDispatchHeaderScreen extends StatelessWidget {
  static const routeName = '/inventory_dispatch_header';
  final _scanInputZonation = TextEditingController();
  final _scanInputDay = TextEditingController();

  final List<InventoryDispatchHeader> items = [
    InventoryDispatchHeader(
      docNumber: '150308111MSI-SNIP',
      requireDate: DateTime.now(),
      toWarehouse: 'Harvest Senopati',
      memo: 'Untuk kebutuhan mendesak',
    ),
    InventoryDispatchHeader(
      docNumber: '150308222MSI-SNIP',
      requireDate: DateTime.now(),
      toWarehouse: 'Harvest Veteran',
      memo: 'Untuk kebutuhan mendesak',
    ),
    InventoryDispatchHeader(
      docNumber: '150308333MSI-SNIP',
      requireDate: DateTime.now(),
      toWarehouse: 'Harvest Bintaro',
      memo: 'Untuk kebutuhan mendesak',
    ),
    InventoryDispatchHeader(
      docNumber: '150308444MSI-SNIP',
      requireDate: DateTime.now(),
      toWarehouse: 'Harvest Sentul',
      memo: 'Untuk kebutuhan mendesak',
    ),
    InventoryDispatchHeader(
      docNumber: '150308555MSI-SNIP',
      requireDate: DateTime.now(),
      toWarehouse: 'Harvest Bekasi',
      memo: 'Untuk kebutuhan mendesak',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final invDisHeader =
        Provider.of<InventoryDispatchHeaderProvider>(context, listen: false);

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
            // Todo change dropdown
            TextFormField(
              controller: _scanInputZonation,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Zonation',
                hintText: 'Select Zonation',
              ),
              onChanged: (value) {
                invDisHeader.setZonation(value);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(kMedium),
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              controller: _scanInputDay,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Day',
                hintText: 'Select Day',
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            BaseTitle('List Inventory Transfer'),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return ItemInventoryDispatchHeader(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
