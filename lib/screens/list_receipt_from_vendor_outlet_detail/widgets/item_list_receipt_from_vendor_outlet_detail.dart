import 'package:flutter/material.dart';
import 'package:msi_app/models/list_good_receipt_po_outlet.dart';
import 'package:msi_app/models/list_good_receipt_po_outlet_detail.dart';
import 'package:msi_app/providers/list_grpo_outlet_detail_provider.dart';
import 'package:msi_app/providers/list_grpo_outlet_provider.dart';
import 'package:msi_app/screens/receipt_vendor_rfo/receipt_vendor_rfo_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ItemListReceiptFromVendorOutletDetail extends StatelessWidget {
  final ListGoodReceiptPoOutletDetail itemDetail;

  const ItemListReceiptFromVendorOutletDetail(this.itemDetail);

  void postData(BuildContext context, ListGoodReceiptPoOutlet item) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Cancel This Document'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK?'),
            onPressed: () async {
              print("itemDetail object? $itemDetail");
              final provider =
                  Provider.of<ListGrpoOutletDetailProvider>(context, listen: false);
              provider.selectPo(itemDetail);

              // print("bb  ${itemDetail.status}");
              print("aa  ${provider.selected}");

              // provider.selected.status = itemDetail.status;
              // try {
              final response = await provider.cancelDocument(item.idRtoHeader);
              // final docId = response['id'];
              Navigator.of(context).pop();
              await showSuccessDialog(context);
              // } catch (error) {
              //   Scaffold.of(context).showSnackBar(
              //     SnackBar(
              //       content: Row(
              //         children: [
              //           Icon(Icons.error_outline, color: Colors.red),
              //           SizedBox(width: getProportionateScreenWidth(kLarge)),
              //           Text(error.toString()),
              //         ],
              //       ),
              //     ),
              //   );
              // }
            },
          ),
        ],
      ),
    );
  }

  Future<void> showSuccessDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, color: Colors.green, size: 50),
              Divider(),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Success Cancel Document'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Receipt From Outlet'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        ReceiptVendorRfoScreen.routeName, (route) => false);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final detail =
            Provider.of<ListGrpoOutletProvider>(context, listen: false).selected;

        postData(context, detail);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(kMedium)),
            Expanded(
              child: Column(
                children: [
                  buildButtonCancel(context),
                  BaseTextLine(
                      'Receipt Return from Outlet ID', itemDetail.idRtoHeader.toString()),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  BaseTextLine(
                      'Posting Date', convertDate(itemDetail.postingDate)),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  BaseTextLine('Doc Number', itemDetail.poNo),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Rto Number', itemDetail.rtoNo),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  BaseTextLine(
                      'Delivery Date', convertDate(itemDetail.deliveryDate)),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  BaseTextLine('Outlet Code', itemDetail.kdVendor),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  BaseTextLine('Outlet Name', itemDetail.nmVendor),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  BaseTextLine('WHS Code', itemDetail.plant),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Id Grpo Plant', itemDetail.id),
                  BaseTextLine('Bin Location', itemDetail.storageLocation),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine(
                  //     'Storage Location Name', itemDetail.storageLocationName),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Status', itemDetail.status.toString()),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Item Grup Code', itemDetail.itemGroupCode),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine(
                  //     'Id User Input', itemDetail.idUserInput.toString()),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine(
                  //     'Id User Approved', itemDetail.idUserApproved.toString()),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Filename', itemDetail.fileName),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                   BaseTitleColor( itemDetail.logMessage),
                  SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine(
                  //     'Last Modified', convertDate(itemDetail.lastmodified)),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Docnum', itemDetail.docnum),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Back', itemDetail.back.toString()),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Remark', itemDetail.remark),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                  // BaseTextLine('Rto No 1', itemDetail.rtoNo1.toString()),
                  // SizedBox(width: getProportionateScreenWidth(kSmall)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonCancel(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.red,
        child: Text('Cancel'),
        onPressed: () {
          final detail =
            Provider.of<ListGrpoOutletProvider>(context, listen: false).selected;

        postData(context, detail);
        },
      ),
    );
  }
}
