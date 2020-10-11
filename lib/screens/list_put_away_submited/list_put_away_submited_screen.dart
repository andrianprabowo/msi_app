import 'package:flutter/material.dart';
import 'package:msi_app/models/list_put_away_submited.dart';
import 'package:msi_app/screens/list_put_away_submited/widgets/item_list_put_away_submited.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';

class ListPutAwaySubmitedScreen extends StatelessWidget {
  static const routeName = '/list_put_away_submited';

  final List<ListPutAwaySubmited> items = [
    ListPutAwaySubmited(
      putAwayNumber: 'ITPA MSI 0192319401',
      fromStgBin: 'Staging 001',
      docDate: DateTime.now(),
      binner: 'ABC DEF',
      status: '',
    ),
    ListPutAwaySubmited(
      putAwayNumber: 'ITPA MSI 0192319402',
      fromStgBin: 'Staging 002',
      docDate: DateTime.now(),
      binner: 'ABC DEF',
      status: 'P',
    ),
    ListPutAwaySubmited(
      putAwayNumber: 'ITPA MSI 0192319403',
      fromStgBin: 'Staging 003',
      docDate: DateTime.now(),
      binner: 'ABC DEF',
      status: 'O',
    ),
    ListPutAwaySubmited(
      putAwayNumber: 'ITPA MSI 0192319404',
      fromStgBin: 'Staging 004',
      docDate: DateTime.now(),
      binner: 'ABC DEF',
      status: 'O',
    ),
    ListPutAwaySubmited(
      putAwayNumber: 'ITPA MSI 0192319405',
      fromStgBin: 'Staging 005',
      docDate: DateTime.now(),
      binner: 'ABC DEF',
      status: 'O',
    ),
    ListPutAwaySubmited(
      putAwayNumber: 'ITPA MSI 0192319406',
      fromStgBin: 'Staging 006',
      docDate: DateTime.now(),
      binner: 'ABC DEF',
      status: 'O',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Put Away Submitted'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Put Away'),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return ItemListPutAwaySubmited(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
