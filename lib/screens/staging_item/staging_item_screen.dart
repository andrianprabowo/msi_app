import 'package:flutter/material.dart';
import 'package:msi_app/models/item_bin.dart';
import 'package:msi_app/screens/staging_item/widgets/item_staging_bin.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class StagingItemScreen extends StatelessWidget {
  static const routeName = '/staging_item';
  final _scanInput = TextEditingController();

  final List<ItemBin> items = [
    ItemBin(
      itemCode: 'codeitem 01',
      itemName: 'White Sugar',
    ),
    ItemBin(
      itemCode: 'codeitem 02',
      itemName: 'Black Sugar',
    ),
    ItemBin(
      itemCode: 'codeitem 03',
      itemName: 'Brown Sugar',
    ),
    ItemBin(
      itemCode: 'codeitem 04',
      itemName: 'Yelow Sugar',
    ),
    ItemBin(
      itemCode: 'codeitem 05',
      itemName: 'Pink Sugar',
    ),
    ItemBin(
      itemCode: 'codeitem 06',
      itemName: 'Green Sugar',
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
                labelText: 'Item Barcode',
                hintText: 'Scan Item/ Barcode',
                suffixIcon: IconButton(
                  icon: Icon(Icons.local_see),
                  onPressed: () {
                    _scanInput.text = 'code item 02';
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            buildTitle('List Item'),
            Divider(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  Divider();
                  return ItemStagingBin(items[index]);
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
