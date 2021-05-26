import 'package:flutter/material.dart';
import 'package:msi_app/models/production_receipt_rm_all_transaction_model.dart';
import 'package:msi_app/providers/production_receipt_rm_all_transaction_provider.dart';
import 'package:msi_app/screens/prod_list_pick_list_detail_receipt/prod_list_pick_list_detail_receipt_screen.dart';
import 'package:msi_app/utils/constants.dart';
import 'package:msi_app/utils/size_config.dart';
import 'package:msi_app/widgets/base_text_line.dart';
import 'package:msi_app/widgets/base_title.dart';
import 'package:msi_app/widgets/base_title_color.dart';
import 'package:provider/provider.dart';

class ProductionReceiptRMAllTransactionList extends StatelessWidget {
  final ProductionReceiptRMAllTransactionModel item;

  const ProductionReceiptRMAllTransactionList(this.item);

Widget get status {
    switch (item.status) {
      case 0:
        return Icon(Icons.sms_failed_outlined, color: Colors.red, size: 48);
        break;
      case 1:
        return Icon(Icons.check, color: Colors.green, size: 48);
        break;
      case 2:
        return Icon(Icons.block, color: Colors.blue, size: 48);
        break;
      default:
        return Icon(Icons.help_outline, color: Colors.grey, size: 48);
    }
  }
  
Widget get textStatus {
    switch (item.status) {
      case 2:
        return BaseTitleColor('Canceled');
        break;
      default:
        return Text("");
    }
  }
  @override
  Widget build(BuildContext context) {
   final listProvider =
        Provider.of<ProductionReceiptRMAllTransactionProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        if (item.status == 0) {
          listProvider.selectPo(item);
          Navigator.of(context)
              .pushNamed(ProdListPickListDetailReceiptScreen.routeName, arguments: item);
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(kTiny),
        decoration: kBoxDecoration,
        padding: const EdgeInsets.all(kSmall),
        child: Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(kSmall)),
            status,
            SizedBox(width: getProportionateScreenWidth(kMedium)),
            Expanded(
              child: Column(
                children: [
                  BaseTextLine('Receipt No', item.putAwayNo),
                  BaseTextLine('SR No', item.srno),
                  BaseTextLine('Doc Date', convertDate(item.docDate)),
                  BaseTitle(item.logMessage),
                  textStatus,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
