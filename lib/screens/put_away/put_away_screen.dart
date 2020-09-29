import 'package:flutter/material.dart';
import 'package:msi_app/models/staging_bin.dart';
import 'package:msi_app/screens/put_away/widgets/item_staging.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class PutAwayScreen extends StatelessWidget {
  static const routeName = '/put_away';
  final _scanInput = TextEditingController();

  final List<StagingBin> items = [
    StagingBin(
      binCode: 'STAGGING 01',
      warehouse: 'Warehouse',
    ),
    StagingBin(
      binCode: 'STAGGING 02',
      warehouse: 'Central Kitchen Sentul',
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
            buildTitle('List Stagging Bin'),
            Divider(),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  Divider();
                  return ItemStaging(items[index]);
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
