import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:msi_app/models/item_purchase_order.dart';
import 'package:msi_app/providers/item_po_provider.dart';
import 'package:msi_app/screens/receipt_detail/widgets/item_detail.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class ReceiptDetailScreen extends StatefulWidget {
  static const routeName = '/receipt_detail';

  @override
  _ReceiptDetailScreenState createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  final _scanInput = TextEditingController();
  final _remarks = TextEditingController();
  final _delivery = TextEditingController();

  String get dateString {
    return DateFormat.yMMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var poNumber = ModalRoute.of(context).settings.arguments;
    final itemPoProvider = Provider.of<ItemPoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(kMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow('PO Number', poNumber),
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
                child: FutureBuilder(
                  future: itemPoProvider.getPoDetailByDocNum(poNumber),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Text('An error occured'),
                          ],
                        ),
                      );
                    }

                    List<ItemPurchaseOrder> list = snapshot.data;
                    return (list.length == 0)
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.insert_drive_file,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Text('No Data Available'),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (_, index) {
                              return ItemDetail(list[index]);
                            },
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.print,
          color: Colors.white,
        ),
        onPressed: () {},
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
