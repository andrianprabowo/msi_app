import 'package:flutter/material.dart';
import 'package:msi_app/models/purchase_order.dart';
import 'package:msi_app/providers/purchase_order_provider.dart';
import 'package:msi_app/screens/receipt_vendor/widgets/item_receipt.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:provider/provider.dart';

class ReceiptVendorScreen extends StatelessWidget {
  static const routeName = '/receipt_vendor';
  final _scanInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final poProvider = Provider.of<PurchaseOrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt From Vendor'),
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
                hintText: 'Input or scan PO Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.local_see),
                  onPressed: () {
                    _scanInput.text = 'PO-1234';
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(kLarge),
            ),
            buildTitle('List Purchase Order'),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future: poProvider.getAllPoByWarehouseId(),
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

                  List<PurchaseOrder> list = snapshot.data;
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
                        ))
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            return ItemReceipt(list[index]);
                          },
                        );
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
