import 'package:flutter/material.dart';
import 'package:msi_app/models/item_batch.dart';
import 'package:msi_app/screens/staging_batch/widgets/item_batch_staging.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class StagingBatchScreen extends StatelessWidget {
  static const routeName = '/staging_batch';
  final _scanInput = TextEditingController();
  final _inputQty = TextEditingController();

  final List<ItemBatch> items = [
    ItemBatch(
      batchNumber: 'Batch 01',
      description: 'Batch Sugar',
      availableQty: 100.00,
      inventoryUom: 'kg',
    ),
    ItemBatch(
      batchNumber: 'Batch 02',
      description: 'Batch Sugar',
      availableQty: 90.00,
      inventoryUom: 'kg',
    ),
    ItemBatch(
      batchNumber: 'Batch 03',
      description: 'Batch Sugar',
      availableQty: 80.00,
      inventoryUom: 'kg',
    ),
    ItemBatch(
      batchNumber: 'Batch 04',
      description: 'Batch Sugar',
      availableQty: 70.00,
      inventoryUom: 'kg',
    ),
    ItemBatch(
      batchNumber: 'Batch 05',
      description: 'Batch Sugar',
      availableQty: 60.00,
      inventoryUom: 'kg',
    ),
    ItemBatch(
      batchNumber: 'Batch 06',
      description: 'Batch Sugar',
      availableQty: 50.00,
      inventoryUom: 'kg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Put Away'),
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
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Batch Number',
                hintText: 'Scan Batch Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.local_see),
                  onPressed: () {
                    _scanInput.text = 'Batch 002';
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            TextFormField(
              controller: _inputQty,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Quantity',
                hintText: 'Input Quantity',
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            Text("Item Code"),
            Text("Item Name"),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            buildTitle('List Batch of Itemn'),
            Divider(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  Divider();
                  return ItemBatchStaging(items[index]);
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
