import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item.dart';
import 'package:msi_app/screens/receipt_detail/widgets/item_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';

class ReceiptDetailScreen extends StatefulWidget {
  static const routeName = '/receipt_detail';

  @override
  _ReceiptDetailScreenState createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  final _scanInput = TextEditingController();
  final _remarks = TextEditingController();
  final _delivery = TextEditingController();

  final List items = [
    Item(
      itemCode: 'ITM-00001',
      itemName: 'Item Name',
      totalReceipt: 0.0,
      receiptQty: 50.0,
      remainingQty: 0.0,
      uom: 'kg',
    ),
    Item(
      itemCode: 'ITM-00002',
      itemName: 'Item Name',
      totalReceipt: 0.0,
      receiptQty: 50.0,
      remainingQty: 0.0,
      uom: 'kg',
    ),
    Item(
      itemCode: 'ITM-00003',
      itemName: 'Item Name',
      totalReceipt: 0.0,
      receiptQty: 50.0,
      remainingQty: 0.0,
      uom: 'kg',
    ),
    Item(
      itemCode: 'ITM-00004',
      itemName: 'Item Name',
      totalReceipt: 0.0,
      receiptQty: 50.0,
      remainingQty: 0.0,
      uom: 'kg',
    ),
  ];

  String get dateString {
    return DateFormat.yMMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
          SizedBox(
            width: getProportionateScreenWidth(kMedium),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(kMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow('PO Number', 'PO-1111111'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              buildRow('Date', dateString),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              buildRemarksFormField(),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              buildDeliveryFormField(),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              buildScanInputFormField(context),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              buildTitle('List Items'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Container(
                height: getProportionateScreenHeight(310),
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      return ItemDetail(items[index]);
                    }),
              )
            ],
          ),
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

  Widget buildDeliveryFormField() {
    return TextFormField(
      controller: _delivery,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Delivery Order',
          hintText: 'Input DO Number'),
    );
  }

  Widget buildRemarksFormField() {
    return TextFormField(
      maxLines: 2,
      controller: _remarks,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kLarge),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Remarks',
        hintText: 'Input Remarks',
      ),
    );
  }

  Widget buildScanInputFormField(BuildContext context) {
    return TextFormField(
      controller: _scanInput,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Item Barcode',
        hintText: 'Scan Item / Barcode',
        suffixIcon: IconButton(
          icon: Icon(Icons.local_see),
          onPressed: () {
            _scanInput.text = 'Item Code 0001';
            FocusScope.of(context).unfocus();
          },
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
