import 'package:flutter/material.dart';
import 'package:msi_app/models/list_good_receipt_po.dart';
import 'package:msi_app/screens/list_receipt_from_vendor/widgets/item_list_receipt_from_vendor.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_title.dart';

class ListReceiptFromVendorScreen extends StatelessWidget {
  static const routeName = '/list_receipt_from_vendor';

  final List<ListGoodReceiptPo> items = [
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319411',
      poNumber: 'Po 1238751211',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: '',
    ),
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319412',
      poNumber: 'Po 1238751212',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: 'O',
    ),
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319413',
      poNumber: 'Po 1238751213',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: 'P',
    ),
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319411',
      poNumber: 'Po 1238751211',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: 'P',
    ),
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319411',
      poNumber: 'Po 1238751211',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: 'P',
    ),
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319411',
      poNumber: 'Po 1238751211',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: 'P',
    ),
    ListGoodReceiptPo(
      grpoNumber: 'GRPO MSI 0192319411',
      poNumber: 'Po 1238751211',
      docDate: DateTime.now(),
      vendor: 'VEndor ABC DEF',
      status: 'P',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Receipt From Vendor'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            BaseTitle('List Good Receipt PO'),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return ItemListReceiptFromVendor(items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
