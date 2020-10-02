import 'package:flutter/material.dart';
import 'package:msi_app/models/inventory_to_whs.dart';
import 'package:msi_app/screens/return_outlet/widgets/item_inventory_to_whs.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class ReturnOutletScreen extends StatelessWidget {
  static const routeName = '/return_outlet';
  final _scanInput = TextEditingController();

  final List<InventoryToWhs> items = [
    InventoryToWhs(
      docNumber: 'Doc 1111',
      docDate: DateTime.now(),
      outlet: 'Outlet Senopati',
      memo: 'Expired Goods',
    ),
    InventoryToWhs(
      docNumber: 'Doc 2222',
      docDate: DateTime.now(),
      outlet: 'Outlet Senopati',
      memo: 'Expired Goods',
    ),
    InventoryToWhs(
      docNumber: 'Doc 3333',
      docDate: DateTime.now(),
      outlet: 'Outlet Senopati',
      memo: 'Expired Goods',
    ),
    InventoryToWhs(
      docNumber: 'Doc 4444',
      docDate: DateTime.now(),
      outlet: 'Outlet Senopati',
      memo: 'Expired Goods',
    ),
    InventoryToWhs(
      docNumber: 'Doc 5555',
      docDate: DateTime.now(),
      outlet: 'Outlet Senopati',
      memo: 'Expired Goods',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return From Outlet'),
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
                hintText: 'Scan / Choose Stagging bin',
                suffixIcon: IconButton(
                  icon: Icon(Icons.local_see),
                  onPressed: () {
                    _scanInput.text = 'Stagging 02';
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            buildTitle('List Inventory Transfer to Warehouse'),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return ItemInventoryToWhs(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
    );
  }
}
