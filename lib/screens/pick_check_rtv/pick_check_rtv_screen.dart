import 'package:flutter/material.dart';
import 'package:msi_app/models/pick_item_receive_rtv.dart';
import 'package:msi_app/providers/auth_provider.dart';
import 'package:msi_app/providers/pick_list_whs_rtv_provider.dart';
import 'package:msi_app/screens/pick_check_rtv/widget/pick_detail_check_rtv.dart';
import 'package:msi_app/screens/picker_pick_rtv/picker_pick_rtv_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/input_scan.dart';
import 'package:msi_app/widgets/item_bin_picklist_rtv.dart';
import 'package:provider/provider.dart';

class PickCheckRtvScreen extends StatelessWidget {
  static const routeName = '/pick_check_rtv';

  void postData(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Post Picker Pick List To Vendor'),
        content: Text('Are you sure want to process?'),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () async {
              final provider =
                  Provider.of<PickListWhsRtvProvider>(context, listen: false);
              try {
                final response = await provider.createPickList();
                final docId = response['id'];
                Navigator.of(context).pop();
                await showSuccessDialog(context, docId);
              } catch (error) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: getProportionateScreenWidth(kLarge)),
                        Text(error.toString()),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> showSuccessDialog(BuildContext context, int docId) async {
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
              Text('Success create Picker Pick List '),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text('Return To Vendor'),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              Text(
                docId.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(kLarge)),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        PickerPickRtvScreen.routeName, (route) => false);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PickListWhsRtvProvider>(context, listen: false);
    final item = provider.selected;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Picker Pick List To Vendor'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (authProvider.binId == 'Please Select Bin') {
                final snackBar = SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: getProportionateScreenWidth(kLarge)),
                      Text('Please Select Bin First'),
                    ],
                  ),
                );
                globalKey.currentState.showSnackBar(snackBar);
                return;
              }

              if (provider.detailList.isEmpty) {
                final snackBar = SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red),
                      SizedBox(width: getProportionateScreenWidth(kLarge)),
                      Text('Please Select One or More Item First'),
                    ],
                  ),
                );
                globalKey.currentState.showSnackBar(snackBar);
                return;
              } else {
                postData(context);
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kLarge,
          horizontal: kMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseTextLine('Pick Number', item.pickNumber),
            BaseTextLine('Pick Date', convertDate(item.pickDate)),
            BaseTextLine('Remark', item.pickRemark),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTextLine('Vendor Code', item.cardCode),
            BaseTextLine('Vendor Name', item.cardName),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            // buildInputScan(context),
            ItemBinPicklistRtv(),
            SizedBox(height: getProportionateScreenHeight(kLarge)),
            BaseTitle('List Item Details'),
            Divider(),
            buildItemDetails(provider.detailList),
          ],
        ),
      ),
    );
  }

  Widget buildItemDetails(List<PickItemReceiveRtv> list) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) {
          return PickDetailCheckRtv(list[i]);
        },
      ),
    );
  }

  Widget buildInputScan(BuildContext context) {
    final provider =
        Provider.of<PickListWhsRtvProvider>(context, listen: false);
    return InputScan(
      label: 'Storage Location',
      hint: 'Input or scan Storage Location',
      scanResult: (value) {
        provider.selected.storageLocation = value;
        // final item = provider.findByPoNumber(value);
        // provider.selectPo(item);
        // Navigator.of(context).pushNamed(ReceiptDetailScreen.routeName);
      },
    );
  }
}
